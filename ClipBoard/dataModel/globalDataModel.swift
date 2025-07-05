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
    @Published var text: [String] = []
}
