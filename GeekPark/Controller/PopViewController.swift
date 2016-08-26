//
//  PopViewController.swift
//  GeekPark
//
//  Created by lan on 16/8/25.
//  Copyright © 2016年 lan. All rights reserved.
//

import Cocoa

class PopViewController: NSViewController {
    let httphelper = HttpHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        httphelper.getNews()
    }
}

extension PopViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return 5;
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        
        if tableColumn?.identifier == "GeekParkCell" {
            cellView.textField?.stringValue = "test"
            return cellView
        }
        return cellView
    }
}

extension PopViewController: NSURLSessionTaskDelegate {
    
}
