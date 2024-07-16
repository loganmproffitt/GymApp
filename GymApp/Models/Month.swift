import Foundation

struct Month: Identifiable, Codable {
    var id = UUID()
    var monthName: String
    var monthNumber: Int
    var dayCount: Int
    var year: Int
    var days: [Day]
    
    static var `default`: Month {
        Month(monthName: "", monthNumber: 1, dayCount: 30, year: 0, days: [])
    }
    
    init(monthName: String, monthNumber: Int, dayCount: Int, year: Int, days: [Day])
    {
        self.monthName = monthName
        self.monthNumber = monthNumber
        self.dayCount = dayCount
        self.year = year
        self.days = days
    }
}

