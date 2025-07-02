//
//  pasteBoardManager.swift
//  SXBoard
//
//  Created by Evan Matthew on 2/7/25.
//

import Foundation
import AppKit

class PasteBoardManager: NSObject {
    private var changeCountTracker: Int = NSPasteboard.general.changeCount
    private var clipBoardTimer: Timer!
    private let pasteBoard: NSPasteboard = .general
    var updateRate: Double = 0.05
    
    // Entries
    var text: [String] = []

    init(updateRate: Double) {
        self.updateRate = updateRate
        super.init()
    }

    func fetchClipBoard() {
        clipBoardTimer = Timer.scheduledTimer(withTimeInterval: updateRate, repeats: true) { _ in
            if self.changeCountTracker != self.pasteBoard.changeCount {
                self.changeCountTracker = self.pasteBoard.changeCount
                self.receiveDataFromPasteBoard()
            }
        }
        RunLoop.current.add(clipBoardTimer, forMode: .common)
    }

    func receiveDataFromPasteBoard() {
        guard let types = pasteBoard.types else {return}
        
        for type in types{
            switch type {
            case .string:
                if let someText = pasteBoard.string(forType: .string) {
                    text.append(someText)
                    print(text)
                }
            default:
          print("ERROR: No such format is supported")
            }
        }
        
    }
}

/*
 if let copiedText = pasteBoard.string(forType: .string) {
     // Avoid duplicates
     if self.text.last != copiedText {
         print("Copied: \(copiedText)")
         self.text.append(copiedText)
     }
 } else {
     print("Unsupported or empty clipboard data.")
 }
 */
