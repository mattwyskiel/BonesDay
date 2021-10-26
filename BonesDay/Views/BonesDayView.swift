//
//  BonesDayView.swift
//  BonesDay
//
//  Created by Matthew Wyskiel on 10/25/21.
//

import SwiftUI

struct BonesDayView: View {
    var bonesDay: Bool? = nil
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea([.top, .bottom])
            Group {
                if bonesDay != nil {
                    if bonesDay! {
                        VStack {
                            Text("🥳")
                                .font(.system(size: 100))
                            Text("Bones Day")
                        }
                    } else {
                        VStack {
                            Text("😴")
                                .font(.system(size: 100))
                            Text("No Bones Day")
                        }
                    }
                } else {
                    VStack {
                        Text("💬")
                            .font(.system(size: 100))
                        Text("No Data...")
                    }
                }
            }
        }
    }
    
    var backgroundColor: Color {
        if bonesDay != nil {
            if bonesDay! {
                return Color.green
            } else {
                return Color(red: 253/250, green: 106/250, blue: 2/250)
            }
        } else {
            return Color(uiColor: .lightGray)
        }
    }
}

struct BonesDayView_Previews: PreviewProvider {
    static var previews: some View {
        BonesDayView()
        BonesDayView(bonesDay: false)
        BonesDayView(bonesDay: true)
    }
}
