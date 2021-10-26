//
//  BonesDayViewModel.swift
//  BonesDay
//
//  Created by Matthew Wyskiel on 10/25/21.
//

import Foundation

class BonesDayViewModel: ObservableObject {
    @Published var bonesDay: Bool? = nil
    
    func refreshBonesDay(_ date: Date = Date()) async {
        let bonesHistory = try? await BonesDayHistoryService.getBonesHistory()
        if bonesHistory != nil {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let dateString = formatter.string(from: date)
            
            if (bonesHistory![dateString] != nil) {
                await MainActor.run {
                    bonesDay = bonesHistory![dateString]?.bones
                }
            }
        }
    }
}
