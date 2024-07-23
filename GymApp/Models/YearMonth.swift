import Foundation

struct YearMonth: Hashable {
    var year: Int
    var month: Int
    
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
}
