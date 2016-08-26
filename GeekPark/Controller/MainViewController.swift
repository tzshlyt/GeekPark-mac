//
//  MainViewController.swift
//  GeekPark
//
//  Created by lan on 16/8/25.
//  Copyright © 2016年 lan. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSSquareStatusItemLength)
    let popover = NSPopover()
    
    override func awakeFromNib() {
        statusItem.image = NSImage(named:"statusIcon")
        statusItem.action = #selector(MainViewController.statusItemClicked(_:))
        
        popover.contentViewController = PopViewController(nibName: "PopViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func statusItemClicked(sender: AnyObject) -> Void{
        if(popover.shown) {
            closePopover(sender)
        }else {
            showPopover(sender)
        }
    }
    
    func closePopover(sender: AnyObject?) -> Void {
        popover.performClose(sender)
    }
    
    func showPopover(sender: AnyObject?) -> Void {
        popover.showRelativeToRect((statusItem.button?.bounds)!, ofView: statusItem.button!, preferredEdge: NSRectEdge.MinY)
    }
}
