//
//  clipsActions.swift
//  SXBoard
//
//  Created by Evan Matthew on 26/7/25.
//

import Foundation
import AppKit

class ClipAction : NSObject {
    
    private let pasteBoard: NSPasteboard = .general
    
    @objc func clipAtIndex(index: Int) {
        guard index < GlobalDataModel.shared.clipBoardItems.count else {
            print("Invalid index: \(index)")
            return
        }
        
        let item = GlobalDataModel.shared.clipBoardItems[index]
        switch item.type {
        case .text:
            print("Not implemented yet")
        case .image:
            GlobalDataModel.shared.changeCountTracker = GlobalDataModel.shared.pasteBoard.changeCount
            GlobalDataModel.shared.clipBoardTimer.invalidate()
            GlobalDataModel.shared.changeCountTracker = GlobalDataModel.shared.pasteBoard.changeCount
            guard let image = item.image else {
                print("ERROR: No image data in ClipBoardItem")
                return
            }
            GlobalDataModel.shared.skipInternalApplicationClipBoardChange = true
            defer { GlobalDataModel.shared.skipInternalApplicationClipBoardChange = false }
            
            pasteBoard.clearContents()
            pasteBoard.setData(GlobalDataModel.shared.clipBoardItems[index].image, forType: .png)
            GlobalDataModel.shared.changeCountTracker = GlobalDataModel.shared.pasteBoard.changeCount
            PasteBoardManager.fetchClipBoard()
        case .none:
            print("ERROR ClipAction")
        }
    }

}

