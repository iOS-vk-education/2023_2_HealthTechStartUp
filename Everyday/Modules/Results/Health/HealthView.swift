//
//  HealthView.swift
//  Everyday
//
//  Created by Yaz on 19.05.2024.
//

import SwiftUI

struct HealthView: View {
    @ObservedObject var healthService: HealthService
    
    var body: some View {
        VStack {
            LazyVGrid(
                columns: Array(repeating: GridItem(spacing: 25), count: 2),
                spacing: 25
            ) {
                ForEach(healthService.activities.sorted(by: { $0.value.id < $1.value.id }), id: \.key) { item in
                    ActivityCard(activity: item.value)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(uiColor: .background))
        .onAppear {
            healthService.fetchTodaySteps()
            healthService.fetchTodayCalories()
            healthService.fetchTodayDistance()
            healthService.fetchAverageHeartRate()
            healthService.fetchWeeklySteps()
            healthService.fetchFlightClimbed()
        }
    }
}
