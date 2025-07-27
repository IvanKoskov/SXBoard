//
//  socialsViewController.swift
//  SXBoard
//
//  Created by Evan Matthew on 26/7/25.
//

import Foundation
import AppKit
import SwiftUI

class socialsViewController : NSViewController, NSWindowDelegate {
    var mainView: NSHostingView = NSHostingView(rootView: socialsView())
    var bluryView: NSVisualEffectView!
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 200, height: 400))
        self.view.wantsLayer = true
        //self.view.layer?.backgroundColor = NSColor.white.cgColor
        self.bluryView = NSVisualEffectView(frame: self.view.bounds)
        self.bluryView.autoresizingMask = [.width, .height]  // resizes with window
        self.bluryView.blendingMode = .behindWindow
        if #available(macOS 10.14, *) {
            self.bluryView.material = .hudWindow
        } else {
            self.bluryView.material = .sidebar
        }
        self.bluryView.state = .active
        self.bluryView.alphaValue = 0.5
        self.view.addSubview(bluryView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainView)
        mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}
