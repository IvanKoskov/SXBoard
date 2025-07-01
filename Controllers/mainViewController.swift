//
//  mainViewController.swift
//  SXBoard
//
//  Created by Evan Matthew on 1/7/25.
//

import Foundation
import Cocoa

class MainViewController : NSViewController, NSWindowDelegate {
    
    override func loadView() {
        let mainView = NSView()
        mainView.frame = NSRect(x: 0, y: 0, width: 400, height: 300)
        mainView.wantsLayer = true
        mainView.layer?.cornerRadius = 15
        mainView.layer?.backgroundColor = NSColor.white.cgColor
        self.view = mainView
        
        let blurView = NSVisualEffectView(frame: self.view.bounds)
        blurView.autoresizingMask = [.width, .height]  // resizes with window
        blurView.blendingMode = .behindWindow
        if #available(macOS 10.14, *) {
            blurView.material = .hudWindow
        } else {
            blurView.material = .sidebar
        }
        blurView.state = .active

        self.view.addSubview(blurView)
        
        
        
    }
    
}
