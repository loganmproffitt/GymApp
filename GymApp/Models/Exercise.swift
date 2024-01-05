//
//  Exercise.swift
//  GymApp
//
//  Created by Logan Proffitt on 1/2/24.
//

import Foundation

struct Exercise: Identifiable, Codable {
    var id = UUID()
    var name: String
    var sets: [Set]
    
    static var `default`: Exercise {
        Exercise(name: "", sets: [Set.default])
    }
    
    init(name: String, sets: [Set] = []) {
        self.name = name
        self.sets = sets
    }
}
