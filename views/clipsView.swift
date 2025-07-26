//
//  clipsView.swift
//  SXBoard
//
//  Created by Evan Matthew on 17/7/25.
//

import SwiftUI

struct clipsView: View {
    @EnvironmentObject private var globalData: GlobalDataModel
    var body: some View {
        VStack{
            ScrollView{
                Text("Testing")
            }
            .navigationTitle("Clips vault")
        }
    }
}
