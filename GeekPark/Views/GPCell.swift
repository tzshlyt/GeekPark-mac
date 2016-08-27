//
//  GPCell.swift
//  GeekPark
//
//  Created by lan on 16/8/27.
//  Copyright © 2016年 lan. All rights reserved.
//

import Cocoa
import Kingfisher

class GPCell: NSTableCellView {
    @IBOutlet weak var imgView:NSImageView!
    @IBOutlet weak var titleText: NSTextField!
    @IBOutlet weak var categoryText: NSTextField!
    @IBOutlet weak var timeText: NSTextField!
    
    func setupModel(model: GPModel) {
        self.titleText.stringValue = model.title
        self.categoryText.stringValue = model.category
        self.timeText.stringValue = model.time
        self.imgView.kf_setImageWithURL(NSURL(string: model.imgUrl), placeholderImage: NSImage(named: "test"))
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
