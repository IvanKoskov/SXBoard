//
//  globalDataModel.swift
//  SXBoard
//
//  Created by Evan Matthew on 3/7/25.
//

import Foundation
import Combine

/*
 GloabalDataModel is in control of all state of the SXBoard itself (settings, clips, more)
 */

class GlobalDataModel : ObservableObject {
    static var shared = GlobalDataModel()
    
    // Entries and other supporting data
    @Published var clipBoardSavedItemsLimit: Int = 10
    @Published var showMainApplicationOptional: Int = 0 // 0 for default (show) and 1 for blocking
    @Published var text: [String] = [] // Most of regular strings
    
    @Published var totalItemsCount: Int!
    
    // Goes through the different types like text, images and etc and calculates the size
    // Works per call and is not kept, need to run fucntion every time clip is managed
    func totalNumberOfClips() -> Int {
        var total: Int = text.count // + images.count + .....
        self.totalItemsCount = total
        return self.totalItemsCount
    }
}
