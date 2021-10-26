//
//  BonesDayModel.swift
//  BonesDay
//
//  Created by Matthew Wyskiel on 10/25/21.
//

import Foundation

struct BonesEntry: Codable {
    var bones: Bool
}

typealias BonesHistory = [String: BonesEntry]
