//
//  mainViewController.swift
//  SXBoard
//
//  Created by Evan Matthew on 1/7/25.
//

import Foundation
import Cocoa

class MainViewController: NSViewController, NSWindowDelegate {
    
    var hideWindow: NSButton!
    var lockWindowFixedPosition: NSButton!
    
    override func loadView() {
        let mainView = NSView()
        mainView.frame = NSRect(x: 0, y: 0, width: 400, height: 300)
        mainView.wantsLayer = true
        mainView.layer?.cornerRadius = 15
        mainView.layer?.backgroundColor = NSColor.white.cgColor
        self.view = mainView
        
        let blurView = NSVisualEffectView(frame: self.view.bounds)
        blurView.autoresizingMask = [.width, .height]
        blurView.blendingMode = .behindWindow
        if #available(macOS 10.14, *) {
            blurView.material = .hudWindow
        } else {
            blurView.material = .sidebar
        }
        blurView.state = .active
        self.view.addSubview(blurView)
        
        
        if let image = NSImage(systemSymbolName: "xmark", accessibilityDescription: nil) {
            hideWindow = NSButton(image: image, target: self, action: #selector(hideWindowAction))
        } else {
            hideWindow = NSButton(title: "X", target: self, action: #selector(hideWindowAction))
        }
        
        hideWindow.isBordered = false
        hideWindow.frame = NSRect(x: 370, y: 270, width: 20, height: 20) // adjusted for 400x300
        hideWindow.autoresizingMask = [.minXMargin, .minYMargin]
        self.view.addSubview(hideWindow)
        
        if let image = NSImage(systemSymbolName: "circle", accessibilityDescription: nil) {
            lockWindowFixedPosition = NSButton(image: image, target: self, action: #selector(lockWindow))
        } else {
            lockWindowFixedPosition = NSButton(title: "X", target: self, action: #selector(lockWindow))
        }
        
        lockWindowFixedPosition.isBordered = false
        lockWindowFixedPosition.frame = NSRect(x: 355, y: 270, width: 20, height: 20)
        lockWindowFixedPosition.autoresizingMask = [.minXMargin, .minYMargin]
        self.view.addSubview(lockWindowFixedPosition)
        
    }
    
    // MARK: - Button Action
    @objc func hideWindowAction() {
        view.window?.orderOut(nil)  
    }

   
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        return true
    }
    
    @objc func lockWindow(){
        
        if  (self.view.window?.isMovableByWindowBackground == false) {
            self.view.window?.isMovableByWindowBackground = true
        } else if (self.view.window?.isMovableByWindowBackground == true) {
            self.view.window?.isMovableByWindowBackground = false
        }
        
    }
}
