//
//  ActivityView.swift
//  Everyday
//
//  Created by Alexander on 20.05.2024.
//

import SwiftUI

struct ActivityView: View {
    @StateObject private var viewModel = ActivityViewModel()
    let daysPerRow: Int = 7
    let totalDays: Int = 91
    
    var body: some View {
        HStack {
            ForEach(Array((0..<totalDays / daysPerRow).reversed()), id: \.self) { row in
                VStack {
                    ForEach(Array((0..<daysPerRow).reversed()), id: \.self) { dayIndex in
                        let overallIndex = (row * daysPerRow) + dayIndex
                        if overallIndex < totalDays {
                            let date = getDate(forDayIndex: overallIndex)
                            let contributionExists = viewModel.contributionData.contains(date)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(contributionExists ? Color.green : Color.gray)
                                .frame(width: 18, height: 18)
                        }
                    }
                }
            }
        }
        .padding()
        .background(
            Rectangle()
                .fill(Color(uiColor: .gray.withAlphaComponent(0.1)))
                .cornerRadius(8)
        )
    }
    
    private func getDate(forDayIndex dayIndex: Int) -> Date {
        let calendar = Calendar.current
        let currentDate = Calendar.current.startOfDay(for: Date())
        let dateComponents = calendar.date(byAdding: .day, value: -(dayIndex + 1), to: currentDate)!
        return calendar.startOfDay(for: dateComponents)
    }
}

#Preview {
    return ActivityView()
}
