//
//  watermarkViewController.swift
//  SXBoard
//
//  Created by Evan Matthew on 1/7/25.
//

import Foundation
import Cocoa
import HotKey

class WatermarkViewController : NSViewController, NSWindowDelegate {
    var message: NSTextField!
    var hideHUD: HotKey!
    var hidden: Bool = false
    
    override func loadView() {
        let hudView = NSView()
        hudView.frame = NSRect(x: 0, y: 0, width: 340, height: 40)
        
        hudView.wantsLayer = true
        hudView.layer?.cornerRadius = 15
        hudView.layer?.backgroundColor = .black
        hudView.layer?.masksToBounds = true

        self.view = hudView
        
        message = NSTextField(string: "Unlicensed SXBoard Build 1.0.0 Apple Silicon")
        message.textColor = .white
        message.isEditable = false
        message.isBezeled = false
        message.drawsBackground = false
        message.isSelectable = false
        message.font = .systemFont(ofSize: 14, weight: .bold)
        message.frame = NSRect(x: 10, y: -10, width: 315, height: 40)
        
        self.view.addSubview(message)
        self.view.alphaValue = 0
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 1
            self.view.animator().alphaValue = 1
        }
      
    }
    
    override func viewDidLoad() {
        hideHUD =  HotKey(key: .h, modifiers: [.command, .option])
        hideHUD.keyDownHandler = hideBuildInfoHUD
    }
    
    func hideBuildInfoHUD(){
        if (hidden == false) {
            self.view.window?.orderOut(nil)
            hidden = true
        } else {
            self.view.window?.makeKeyAndOrderFront(nil)
            hidden = false
        }
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        return true
    }
    
}
