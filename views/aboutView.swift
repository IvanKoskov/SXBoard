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
            HStack{
                Image(systemName: "paperclip")
                    .font(.system(size: 100))
                    .foregroundStyle(LinearGradient(colors: [.purple, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                Spacer()
            }
            Divider()
                .foregroundColor(Color.white)
            .padding(10)
            Spacer()
        }
        .padding()
        .frame(width: 500, height: 400, alignment: .center)
    }
}

