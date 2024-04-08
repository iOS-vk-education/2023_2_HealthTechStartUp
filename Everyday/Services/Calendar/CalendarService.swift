//
//  CalendarService.swift
//  Everyday
//
//  Created by Alexander on 08.04.2024.
//

import Foundation

protocol CalendarServiceDescription {
    func getWeekdayIndex(from date: Date) -> Int
    func extractDate(date: Date, format: String) -> String
    func isToday(date: Date) -> Bool
}

final class CalendarService: CalendarServiceDescription {
    static let shared: CalendarServiceDescription = CalendarService()
    
    private let calendar = Calendar.current

    private init() {}
    
    func getWeekdayIndex(from date: Date) -> Int {
        let weekdayIndex = calendar.component(.weekday, from: date) - 2
        let localIndex = weekdayIndex == -1 ? 6 : weekdayIndex
        
        return localIndex
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func isToday(date: Date) -> Bool {
        calendar.isDate(Date(), inSameDayAs: date)
    }
}
