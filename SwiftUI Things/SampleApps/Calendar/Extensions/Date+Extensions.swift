import Foundation

extension Date {

    // Returns 10 Months from the current Date!
    var initialLoadMonth: [Month] {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        
        var months: [Month] = []
        
        for offset in -5...4 {
            if let date = calendar.date(byAdding: .month, value: offset, to: self) {
                let monthName = formatter.string(from: date)
                let weeks = date.weeksInMonth
                let month = Month(name: monthName, date: date, weeks: weeks)
                months.append(month)
            }
        }
        
        return months
    }
    
    // Extracting Month´s Week from the given date
    var weeksInMonth: [Week] {
        let calendar = Calendar.current
        guard let monthInterval = calendar.dateInterval(of: .month, for: self),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start)
        else { return [] }
        
        var weeks: [Week] = []
        var currentDate = monthFirstWeek.start
        
        while currentDate < monthInterval.end {
            var days: [Day] = []
            
            for _ in 0..<7 {
                if calendar.isDate(currentDate, equalTo: self, toGranularity: .month) {
                    let value = calendar.component(.day, from: currentDate)
                    let day = Day(value: value, date: currentDate, isPlaceholder: false)
                    days.append(day)
                    
                } else {
                    // Placeholder
                    days.append(.init(isPlaceholder: true))
                }
                
                /// Updating Current Date
                currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
            }
            
            let week = Week(days: days)
            weeks.append(week)
            
        }
        
        /// Setting up the last week
        if let lastIndex = weeks.indices.last {
            weeks[lastIndex].isLast = true
        }
        
        return weeks
    }
}
