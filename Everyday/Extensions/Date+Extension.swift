//
//  Date+Extension.swift
//  Everyday
//
//  Created by Alexander on 08.04.2024.
//

import Foundation

extension Date {
    var onlyDate: Date? {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        dateComponents.timeZone = TimeZone.current
        return calendar.date(from: dateComponents)
    }
    
    func convertToMonthDayYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM_dd_yyyy"
        return dateFormatter.string(from: self)
    }
}
