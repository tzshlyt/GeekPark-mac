//
//  PopViewController.swift
//  GeekPark
//
//  Created by lan on 16/8/25.
//  Copyright © 2016年 lan. All rights reserved.
//

import Cocoa

class PopViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var uptimeTextView: NSTextField!
    
    let httphelper = HttpHelper()
    var models = [GPModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        httphelper.getNews { result in
            self.models = result
            self.tableView.reloadData()
            self.setTime()
        }
    }
    
    func setTime() {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .MediumStyle
        let timeStr = formatter.stringFromDate(NSDate())
        uptimeTextView.stringValue = "更新时间 \(timeStr)"
    }
    
    @IBAction func settingBtnClick(sender: AnyObject) {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "退出", action: #selector(quit), keyEquivalent: "q"))
        
        NSMenu.popUpContextMenu(menu, withEvent: NSApp.currentEvent!, forView: sender as! NSView)
    }
    
    func quit() {
        NSApplication.sharedApplication().terminate(self)
    }
}

extension PopViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return models.count;
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: tableView) as! GPCell
        
        if tableColumn!.identifier == "GeekParkCell" {
            let model = self.models[row]
            cellView.setupModel(model)
            return cellView
        }
        return cellView
    }
}

extension PopViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(notification: NSNotification) {
        let table = notification.object as! NSTableView
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: models[table.selectedRow].href)!)
    }
}
