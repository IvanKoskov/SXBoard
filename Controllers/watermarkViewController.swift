//
//  watermarkViewController.swift
//  SXBoard
//
//  Created by Evan Matthew on 1/7/25.
//

import Foundation
import Cocoa

class WatermarkViewController : NSViewController, NSWindowDelegate {
    var message: NSTextField!
    
    override func loadView() {
        let hudView = NSView()
        hudView.frame = NSRect(x: 0, y: 0, width: 260, height: 40)
        
        hudView.wantsLayer = true
        hudView.layer?.cornerRadius = 15
        hudView.layer?.backgroundColor = .clear
        hudView.layer?.masksToBounds = true

        self.view = hudView
        
        message = NSTextField(string: "SXBoard Build 1.0.0 Apple Silicon")
        message.textColor = .white
        message.isEditable = false
        message.isBezeled = false
        message.drawsBackground = false
        message.isSelectable = false
        message.font = .systemFont(ofSize: 14, weight: .bold)
        message.frame = NSRect(x: 10, y: -10, width: 250, height: 40)
        
        self.view.addSubview(message)
        /*
        NSLayoutConstraint.activate([
            message.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 3),
            message.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 6),
        ])
*/
        
      
    }
    
}



/*  message = Text(text: "Build 1.0.0 ARM")
 
 self.view.addSubview(message)
 
 NSLayoutConstraint.activate([
     message.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
     message.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
 ])*/
