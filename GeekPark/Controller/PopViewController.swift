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
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        let timeStr = formatter.string(from: Date())
        uptimeTextView.stringValue = "更新时间 \(timeStr)"
    }
    
    @IBAction func settingBtnClick(_ sender: AnyObject) {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "退出", action: #selector(quit), keyEquivalent: "q"))
        
        NSMenu.popUpContextMenu(menu, with: NSApp.currentEvent!, for: sender as! NSView)
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
}

extension PopViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return models.count;
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: tableView) as! GPCell
        
        if tableColumn!.identifier.rawValue == "GeekParkCell" {
            let model = self.models[row]
            cellView.setupModel(model)
            return cellView
        }
        return cellView
    }
}

extension PopViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        let table = notification.object as! NSTableView
        NSWorkspace.shared.open(URL(string: models[table.selectedRow].href)!)
    }
}
