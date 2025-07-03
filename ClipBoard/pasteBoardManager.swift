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
    //var text: [String] = []

    init(updateRate: Double) {
        self.updateRate = updateRate
        super.init()
        GlobalDataModel.shared.$text.sink{
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
                if let someText = pasteBoard.string(forType: .string) {
                    GlobalDataModel.shared.text.append(someText)
                    print(GlobalDataModel.shared.text)
                }
            default:
          print("ERROR: No such format is supported")
            }
        }
        
    }
}

