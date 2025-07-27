//
//  mainAboutViewController.swift
//  SXBoard
//
//  Created by Evan Matthew on 26/7/25.
//
import AppKit
import SwiftUI

class mainAboutViewController : NSViewController, NSWindowDelegate {
   
    var mainView: NSHostingView = NSHostingView(rootView: aboutView())
    var bluryView: NSVisualEffectView!
    
    override func loadView() {
       // super.loadView()
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 200, height: 100))
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.gray.cgColor
      //  self.view.addSubview(mainView)
        self.bluryView = NSVisualEffectView(frame: self.view.bounds)
        self.bluryView.autoresizingMask = [.width, .height]  // resizes with window
        self.bluryView.blendingMode = .behindWindow
        if #available(macOS 10.14, *) {
            self.bluryView.material = .hudWindow
        } else {
            self.bluryView.material = .sidebar
        }
        self.bluryView.state = .active
        self.view.addSubview(bluryView)
        self.view.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}
