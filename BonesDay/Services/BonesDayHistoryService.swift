//
//  BonesDayHistoryService.swift
//  BonesDay
//
//  Created by Matthew Wyskiel on 10/25/21.
//

import Foundation

class BonesDayHistoryService {
    static func getBonesHistory() async throws -> BonesHistory {
        let request = URLRequest(url: URL(string: "https://isitabonesday.com/history.json")!)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(BonesHistory.self, from: data)
    }
}
