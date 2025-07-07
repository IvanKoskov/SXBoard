//
//  clipBoardItem.swift
//  SXBoard
//
//  Created by Evan Matthew on 7/7/25.
//

import Foundation
import AppKit

struct ClipBoardItem : Codable {
    var text: String?
    var image: Data?
    
    init(text: String? = nil, image: NSImage? = nil) {
        self.text = text
        if let imageReceived = image {
            self.image = imageReceived.tiffRepresentation
        }
    }
    
    func imageFromData() -> NSImage? {
        guard let data = self.image else { return nil}
        return NSImage(data: data)
    }
}
