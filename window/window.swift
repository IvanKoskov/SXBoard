//
//  window.swift
//  SXBoard
//
//  Created by Evan Matthew on 1/7/25.
//

import Foundation
import Cocoa

enum Position {
    case topLeftCorner
    case topRightCorner
    case bottomRightCorner
    case bottomLeftCorner
}

class Window : NSWindow {
    
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }

    public static func snapTo(_ pos: Position, size: NSSize = NSSize(width: 400, height: 300)) -> NSRect {
        guard let screen = NSScreen.main else {
            // Fallback to a default rect if no main screen is available
            return NSRect(x: 0, y: 0, width: size.width, height: size.height)
        }
        
        let screenFrame = screen.visibleFrame // Use visibleFrame to avoid menu bar and dock
        let rectWidth = size.width
        let rectHeight = size.height
        
        switch pos {
        case .bottomLeftCorner:
            return NSRect(x: screenFrame.minX,
                          y: screenFrame.minY,
                          width: rectWidth,
                          height: rectHeight)
        case .bottomRightCorner:
            return NSRect(x: screenFrame.maxX - rectWidth,
                          y: screenFrame.minY,
                          width: rectWidth,
                          height: rectHeight)
        case .topLeftCorner:
            return NSRect(x: screenFrame.minX,
                          y: screenFrame.maxY - rectHeight,
                          width: rectWidth,
                          height: rectHeight)
        case .topRightCorner:
            return NSRect(x: screenFrame.maxX - rectWidth,
                          y: screenFrame.maxY - rectHeight,
                          width: rectWidth,
                          height: rectHeight)
        }
    }
    
 
}
