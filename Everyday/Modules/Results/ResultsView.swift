//
//  ResultsView.swift
//  Everyday
//
//  Created by Alexander on 20.05.2024.
//

import SwiftUI

struct ResultsView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Activity")
                    .font(.title)
                ActivityView()
            }
            VStack(alignment: .leading) {
                Text("Weight")
                    .font(.title)
                WeightFatView(healthService: HealthService.shared)
            }
            .padding()
            VStack(alignment: .leading) {
                Text("Photos")
                    .font(.title)
                PhotoLibraryLinkView()
            }
            .padding()
            VStack(alignment: .leading) {
                Text("Health")
                    .font(.title)
                HealthView(healthService: HealthService.shared)
            }
            .padding()
        }
        .background(Color.background)
    }
}

#Preview {
    ResultsView()
}
