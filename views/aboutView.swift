//
//  aboutView.swift
//  SXBoard
//
//  Created by Evan Matthew on 26/7/25.
//

import SwiftUI

struct aboutView: View {
    var body: some View {
        VStack {
            if #available(macOS 12.0, *) {
                Image(systemName: "paperclip")
                    .font(.system(size: 150))
                    .foregroundStyle(LinearGradient(colors: [.purple, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
            } else {
            
            }
        }
        .frame(width: 500, height: 400, alignment: .center)
    }
}

