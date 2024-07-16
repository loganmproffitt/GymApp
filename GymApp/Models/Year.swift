import Foundation

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
        // Initialize names and days in month
        let nameAndDays = [("January", 31), ("February", 29), ("March", 31), ("April", 30), ("May", 31), ("June", 30), ("July", 31), ("August", 31), ("September", 30), ("October", 31), ("November", 30), ("December", 31)]
        
        // Create months objects
        var months: [Month] = []
        for (index, (name, days)) in nameAndDays.enumerated() {
            let month = Month(monthName: name, monthNumber: index + 1, dayCount: days, year: year, days: [])
            months.append(month)
        }
        return months
    }
}
