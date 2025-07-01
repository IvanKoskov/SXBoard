//
//  button.swift
//  SXBoard
//
//  Created by Evan Matthew on 1/7/25.
//
import Cocoa

class Text: NSTextField {
    init(text: String) {
        super.init(frame: .zero)
        self.stringValue = text
        self.textColor = .white
        self.isEditable = false
        self.isBezeled = false
      //  self.drawsBackground = false
        self.isSelectable = true
        self.font = .systemFont(ofSize: 15)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

