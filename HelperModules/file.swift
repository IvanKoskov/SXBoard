//
//  file.swift
//  SXBoard
//
//  Created by Evan Matthew on 1/7/25.
//

import Foundation

import Foundation

class File {
    
    private var fileName: String
    private var pathAt: String
    
    init(fileName: String, pathAt: String) {
        self.fileName = fileName
        self.pathAt = pathAt
    }
    
    func createPlaneConfigFile() -> Bool{
        let fullPath = URL(fileURLWithPath: pathAt).appendingPathComponent(fileName).path
        let manager = FileManager.default
        let record = "IS_NOT_FIRST_LAUNCH"
        
        guard let data = record.data(using: .utf8) else {
            print("Could not encode string.")
            return false
        }

        if !manager.fileExists(atPath: fullPath) {
            manager.createFile(atPath: fullPath, contents: data, attributes: nil)
            print("Created file at: \(fullPath)")
            return true
        } else {
            print("File already exists at: \(fullPath)")
            return false
        }
    }
}

func homeDir() -> URL {
    FileManager.default.homeDirectoryForCurrentUser
}
