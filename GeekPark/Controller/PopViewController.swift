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
    let httphelper = HttpHelper()
    var models = [GPModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        httphelper.getNews { result in
            self.models = result
            self.tableView.reloadData()
        }
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
