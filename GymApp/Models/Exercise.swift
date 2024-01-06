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
    var completed: Bool
    var notes: String
    var sets: [Set]
    
    static var `default`: Exercise {
        Exercise(name: "", completed: false, notes: "", sets: [Set.default])
    }
    
    init(name: String, completed: Bool, notes: String, sets: [Set] = []) {
        self.name = name
        self.sets = sets
        self.notes = notes
        self.completed = completed
    }
}
