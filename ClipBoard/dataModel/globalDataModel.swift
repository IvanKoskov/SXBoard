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
    @Published var text: [String] = []
}
