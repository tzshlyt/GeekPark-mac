//
//  GPCell.swift
//  GeekPark
//
//  Created by lan on 16/8/27.
//  Copyright © 2016年 lan. All rights reserved.
//

import Cocoa

class GPCell: NSTableCellView {
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var imgView:NSImageView!

    func setupModel(model: GPModel) {
        self.titleTextField.stringValue = model.title
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
