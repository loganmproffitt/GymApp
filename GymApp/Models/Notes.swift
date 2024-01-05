//
//  Notes.swift
//  GymApp
//
//  Created by Logan Proffitt on 1/2/24.
//

import Foundation

struct Notes: Identifiable, Codable {
    var id = UUID()
    var notes: String
    var bodyWeight: Float
}
