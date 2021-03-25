//
//  MainViewController.swift
//  GeekPark
//
//  Created by lan on 16/8/25.
//  Copyright © 2016年 lan. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    private lazy var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private let popover = NSPopover()
    
    override func awakeFromNib() {
        statusItem.image = NSImage(named:"statusIcon")
        statusItem.action = #selector(MainViewController.statusItemClicked(_:))
        
        popover.contentViewController = PopViewController(nibName: "PopViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @objc func statusItemClicked(_ sender: AnyObject) -> Void{
        if(popover.isShown) {
            closePopover(sender)
        }else {
            showPopover(sender)
        }
    }
    
    func closePopover(_ sender: AnyObject?) -> Void {
        popover.performClose(sender)
    }
    
    func showPopover(_ sender: AnyObject?) -> Void {
        popover.show(relativeTo: (statusItem.button?.bounds)!, of: statusItem.button!, preferredEdge: NSRectEdge.minY)
    }
}
