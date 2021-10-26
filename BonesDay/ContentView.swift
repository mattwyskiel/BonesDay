//
//  ContentView.swift
//  BonesDay
//
//  Created by Matthew Wyskiel on 10/25/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = BonesDayViewModel()
    var body: some View {
        BonesDayView(bonesDay: viewModel.bonesDay)
            .task {
                await viewModel.refreshBonesDay()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
