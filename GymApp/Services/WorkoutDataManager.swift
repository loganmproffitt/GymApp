//
//  WorkoutDataManager.swift
//  GymApp
//
//  Created by Logan Proffitt on 1/5/24.
//

import Foundation

class WorkoutDataManager {
    static let shared = WorkoutDataManager()
    private let fileName = "workouts.json"
    
    // Get path and append filename
    private var fileURL : URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    // Write workout data to file
    func saveWorkouts(_ workouts: [Workout]) {
        do {
            let data = try JSONEncoder().encode(workouts)
            try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
            
        } catch {
            print("Error saving workouts: \(error)")
        }
    }
    
    // Read workout data from file
    func loadWorkouts() -> [Workout] {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([Workout].self, from: data)
        } catch {
            print("Error loading workouts: \(error)")
            return []
        }
    }
}
