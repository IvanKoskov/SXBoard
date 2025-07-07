//
//  pasteBoardManager.swift
//  SXBoard
//
//  Created by Evan Matthew on 2/7/25.
//

import Foundation
import AppKit
import Combine

class PasteBoardManager: NSObject {
    private var changeCountTracker: Int = NSPasteboard.general.changeCount
    private var clipBoardTimer: Timer!
    private let pasteBoard: NSPasteboard = .general
    var updateRate: Double = 0.05
    
    // Entries object that holds essentially all clipboard data from as the app launched and started receiving messages
    // Entries holds all types of data that clipboard can receive like text for exmaple2
    private var cancellables =  Set<AnyCancellable>()
    // var text: [String] = [] // This would hold only text clips
    // But we have a shared object that will be managed by the SXBoard
    // It is GlobalDataModel.shared.EXAMPLE
    
    init(updateRate: Double) {
        
        self.updateRate = updateRate
        super.init()
        GlobalDataModel.shared.$clipBoardItems.sink {
            newText in
            print("")
        }
        .store(in: &cancellables)
         
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
                receiveDataWithTypeString()
            default:
          print("ERROR: No such format is supported")
            }
        }
        
    }
    
    func receiveDataWithTypeString(){
        if let someText = pasteBoard.string(forType: .string) {
            let limit = GlobalDataModel.shared.clipBoardSavedItemsLimit
            var items = GlobalDataModel.shared.clipBoardItems
            
            if limit - items.count == 0 {
                items.remove(at: 0)
                var newItem = ClipBoardItem(text: someText)
                items.append(newItem)
            } else if limit - items.count > 0 {
                var newItem = ClipBoardItem(text: someText)
                items.append(newItem)
            } else {
                print("Overflow")
                let overflow = items.count - limit + 1
                items.removeFirst(overflow)
                var newItem = ClipBoardItem(text: someText)
                items.append(newItem)
                limitIsOver()
            }

            GlobalDataModel.shared.clipBoardItems = items
            print(GlobalDataModel.shared.clipBoardItems)
            print(GlobalDataModel.shared.clipBoardItems.count)
        }
    }
}

