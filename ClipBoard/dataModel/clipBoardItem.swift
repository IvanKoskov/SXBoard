//
//  clipBoardItem.swift
//  SXBoard
//
//  Created by Evan Matthew on 7/7/25.
//

import Foundation
import AppKit

enum clipType : Decodable, Encodable {
    case text
    case image
    case none
}

struct ClipBoardItem : Codable {
    var text: String?
    var image: Data?
    var type: clipType = .none
    
    init(text: String? = nil, image: NSImage? = nil) {
        if let textReceived = text {
            self.text = textReceived
            self.type = .text
        }
        if let imageReceived = image {
            self.image = imageReceived.tiffRepresentation
            self.type = .image
        }
    }
    
    func imageFromData() -> NSImage? {
        guard let data = self.image else { return nil}
        return NSImage(data: data)
    }
}
