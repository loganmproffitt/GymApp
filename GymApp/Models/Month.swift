import Foundation

struct Month: Identifiable, Codable {
    var id = UUID()
    var monthName: String
    var monthNumber: Int
    var dayCount: Int
    var year: Int
    var empty: Bool
    var days: [Day]
    
    static var `default`: Month {
        Month(monthName: "", monthNumber: 1, dayCount: 30, year: 0, empty: false, days: [])
    }
    
    init(monthName: String, monthNumber: Int, dayCount: Int, year: Int, empty: Bool, days: [Day])
    {
        self.monthName = monthName
        self.monthNumber = monthNumber
        self.dayCount = dayCount
        self.year = year
        self.empty = empty
        self.days = days
    }
    
    mutating func addWorkout(for components: DateComponents) -> UUID {
        // Set to not empty
        empty = false
        // Get date info
        let weekday = getWeekday(for: components)
        let date = getDate(for: components)
        
        // Check for existing day
        if days.firstIndex(where: { $0.dayNumber == components.day}) == nil {
            // Create day if not found
            let day = Day(weekday: weekday, date: date, dayNumber: components.day!, workouts: [])
            days.append(day)
        }
        // Create day and add to array
        let dayIndex = days.firstIndex(where: { $0.dayNumber == components.day})
        return days[dayIndex!].addWorkout(for: components)
    }
    
    func getDate(for components: DateComponents) -> String {
        let calendar = Calendar.current
        if let date = calendar.date(from: components) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy" // Set the desired date format
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        else {
            return "Error"
        }
    }
        
    func getWeekday(for components: DateComponents) -> String {
        let calendar = Calendar.current
        if let date = calendar.date(from: components) {
            let weekday = calendar.component(.weekday, from: date)
            let dateFormatter = DateFormatter()
            let weekdayName = dateFormatter.weekdaySymbols[weekday - 1]
            return weekdayName
        }
        else {
            return "Error"
        }
    }
}

