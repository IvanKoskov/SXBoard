//
//  statusBarClip.swift
//  SXBoard
//
//  Created by Evan Matthew on 6/7/25.
//

import Foundation
import AppKit
// Class that manages single creation of a simple status bar clip
// It holds the clip itself, managed by user directly

class StatusBarClip : NSObject {
    var isTextBased: Bool // If not it will revert to image based clip
    var clipSlot: NSMenuItem!
    var clip: ClipBoardItem
    
    init(isTextBased: Bool, clip: ClipBoardItem) {
        self.isTextBased = isTextBased
        self.clip = clip
    }
    
    @objc func addClip(){
        
    }
    
    @objc func shouldBeDeleted(){
        
    }
}
