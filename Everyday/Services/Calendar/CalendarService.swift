//
//  CalendarService.swift
//  Everyday
//
//  Created by Alexander on 08.04.2024.
//

import Foundation

protocol CalendarServiceDescription {
    func getWeekdayIndex(from date: Date) -> Int
    func getScheduleElement(from schedule: DayServiceSchedule, at date: Date) -> [DayServiceProgramElement]
    func extractDate(date: Date, format: String) -> String
}

final class CalendarService: CalendarServiceDescription {
    static let shared: CalendarServiceDescription = CalendarService()
    
    private let calendar = Calendar.current

    private init() {}
    
    func getWeekdayIndex(from date: Date) -> Int {
        let weekdayIndex = calendar.component(.weekday, from: date) - calendar.firstWeekday
        let localIndex = weekdayIndex == -1 ? 6 : weekdayIndex
        
        return localIndex
    }
    
    func getScheduleElement(from schedule: DayServiceSchedule, at date: Date) -> [DayServiceProgramElement] {
        let map: [String: [DayServiceProgramElement]] = [
            "Sun".localized: schedule.sunday,
            "Mon".localized: schedule.monday,
            "Tue".localized: schedule.tuesday,
            "Wed".localized: schedule.wednesday,
            "Thu".localized: schedule.thursday,
            "Fri".localized: schedule.friday,
            "Sat".localized: schedule.saturday
        ]
        
        let key = extractDate(date: date, format: "E")
        return map[key] ?? []
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
