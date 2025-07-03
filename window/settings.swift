//
//  settings.swift
//  SXBoard
//
//  Created by Evan Matthew on 3/7/25.
//

import Foundation
import Cocoa

class WindowSettings : Window {
    init(contentR: NSRect, delegate: NSWindowDelegate, viewController: NSViewController) {
        super.init(contentRect: contentR, styleMask: [.borderless], backing: .buffered, defer: false)

        self.backgroundColor = .clear
        self.collectionBehavior  = [.canJoinAllSpaces]
        self.isOpaque = false
        self.orderFrontRegardless()
        self.isMovableByWindowBackground = true
        self.hasShadow = false
        self.title = ""
        self.level = .statusBar
        self.contentViewController = viewController
        self.delegate = delegate

        self.makeKeyAndOrderFront(nil)
    }

    func showWindowIfWasClosed() {
    self.makeKeyAndOrderFront(nil)
    }
}
