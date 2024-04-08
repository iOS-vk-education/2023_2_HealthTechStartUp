//
//  CalendarService.swift
//  Everyday
//
//  Created by Alexander on 08.04.2024.
//

import Foundation

protocol CalendarServiceDescription {
    func getWeekdayIndex(from date: Date) -> Int
}

final class CalendarService: CalendarServiceDescription {
    static let shared: CalendarServiceDescription = CalendarService()
    
    private let calendar = Calendar.current

    private init() {}
    
    func getWeekdayIndex(from date: Date) -> Int {
        let weekdayIndex = calendar.component(.weekday, from: Date()) - 2
        let localIndex = weekdayIndex == -1 ? 6 : weekdayIndex
        
        return localIndex
    }
}
