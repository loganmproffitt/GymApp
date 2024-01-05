//
//  Set.swift
//  GymApp
//
//  Created by Logan Proffitt on 1/2/24.
//

import Foundation

struct Set: Identifiable, Codable {
    var id = UUID()
    var weight: String
    var reps: String
    
    static var `default`: Set {
            Set(weight: "", reps: "")
    }
    
    init(weight: String, reps: String) {
            self.weight = weight
            self.reps = reps
    }
}
