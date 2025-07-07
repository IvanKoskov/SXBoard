//
//  dataManager.swift
//  SXBoard
//
//  Created by Evan Matthew on 4/7/25.
//

import Foundation
import Cocoa
/*
Data manager is one of the data management ways in SXBoard and part of data flow for saving
and laoding contents locally, according to Apple sandbox rules.
*/

class DataManager: NSObject {
    
    private let defaults = UserDefaults.standard
    
    override init() {
        print("Loading local data with user defaults")
    }
    
    @objc func saveData(){
        saveClipBoardSavedItemsLimit()
        saveShowMainApplicationOptional()
        saveClips()
    }
    
    @objc func saveClipBoardSavedItemsLimit(){
        defaults.set(GlobalDataModel.shared.clipBoardSavedItemsLimit, forKey: "clipsLimit")
    }
    
    @objc func saveShowMainApplicationOptional(){
        defaults.set(GlobalDataModel.shared.showMainApplicationOptional, forKey: "showMain")
    }
    
    @objc func saveClips(){
        do {
            let data = try JSONEncoder().encode(GlobalDataModel.shared.clipBoardItems)
            defaults.set(data, forKey: "clips")
        }
        catch {
            print("ERROR encoding clips")
        }
    }
    
    @objc func loadData(){
        loadClipBoardSavedItemsLimit()
        loadShowMainApplicationOptional()
        loadClips()
    }
    
    @objc func loadClips(){
        do {
            guard let savedData = defaults.data(forKey: "clips") else {
                return
            }
            GlobalDataModel.shared.clipBoardItems = try JSONDecoder().decode([ClipBoardItem].self, from: savedData)
        } catch {
            print("ERROR loading clips")
        }
    }
    
    @objc func loadClipBoardSavedItemsLimit(){
        let savedData = defaults.integer(forKey: "clipsLimit")
        GlobalDataModel.shared.clipBoardSavedItemsLimit = savedData
    }
    
    @objc func loadShowMainApplicationOptional(){
        let savedData = defaults.integer(forKey: "showMain")
        GlobalDataModel.shared.showMainApplicationOptional = savedData
    }
    
    
    
    
    
}
