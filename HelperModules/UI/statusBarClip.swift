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
    var clip: NSMenuItem!
    init(isTextBased: Bool) {
        self.isTextBased = isTextBased
    }
    
    @objc func addClip(){
        
    }
    
    @objc func shouldBeDeleted(){
        
    }
}
