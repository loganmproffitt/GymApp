import Foundation

class DateService {
    
    static func getYearMonth(for date: Date) -> YearMonth {
        // Get components
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        
        // Populate struct
        return YearMonth(year: components.year!, month: components.month!)
    }
    
    
    static func getMonthName(for monthNumber: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        
        var dateComponents = DateComponents()
        dateComponents.month = monthNumber
        
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        return dateFormatter.string(from: date!)
    }
    
    static func getFormattedDate(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: date)
    }
    
    static func getWeekday(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}
