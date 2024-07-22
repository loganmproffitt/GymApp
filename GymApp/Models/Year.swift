import Foundation

let nameAndDays = [("January", 31), ("February", 29), ("March", 31), ("April", 30), ("May", 31), ("June", 30), ("July", 31), ("August", 31), ("September", 30), ("October", 31), ("November", 30), ("December", 31)]

struct Year: Identifiable, Codable {
    var id = UUID()
    var year: Int
    var months: [Month]
    
    static var `default`: Year {
        let currentYear = Calendar(identifier: .gregorian).component(.year, from: Date())
        let months = Year.initMonths(year: currentYear)
        return Year(year: currentYear, months: months)
    }
    
    static func initMonths(year: Int) -> [Month] {
        
        // Create months objects
        var months: [Month] = []
        for (index, (name, days)) in nameAndDays.enumerated() {
            let month = Month(monthName: name, monthNumber: index + 1, dayCount: days, year: year, empty: true, days: [])
            months.append(month)
        }
        return months
    }
    
    mutating func addWorkout(for components: DateComponents) -> UUID {
        // If the given month already exists, add the workout to that month
        if let monthIndex = months.firstIndex(where: { $0.monthNumber == components.month}) {
            return months[monthIndex].addWorkout(for: components)
        }
        else {
            // Otherwise, add the new month and add the workout to that month
            let month = Month(monthName: nameAndDays[components.month!].0, monthNumber: components.month!, dayCount: nameAndDays[components.month!].1, year: components.year!, empty: false, days: [])
            months.append(month)
            let monthIndex = months.firstIndex(where: { $0.monthNumber == components.month})
            return months[monthIndex!].addWorkout(for: components)
        }
    }
}
