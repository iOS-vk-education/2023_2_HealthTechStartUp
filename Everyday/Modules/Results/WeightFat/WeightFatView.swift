//
//  WeightFatView.swift
//  Everyday
//
//  Created by Alexander on 20.05.2024.
//

import SwiftUI

struct WeightFatView: View {
    @ObservedObject var healthService: HealthService
    @State var weight: String = ""
    @State var fat: String = ""
    
    var body: some View {
        HStack {
            VStack {
                Text("Weight")
                Text("\(weight)")
            }
            Spacer()
            VStack {
                Text("Fat")
                Text("\(fat) %")
            }
        }
        .onAppear {
            healthService.fetchWeight { result, bodyMass, measure in
                switch result {
                case .success:
                    weight = (bodyMass ?? "?") + " " + (measure ?? "")
                case .failure:
                    weight = "?"
                }
            }
            
            healthService.fetchFatPercentage { result, fatPercent in
                switch result {
                case .success:
                    fat = fatPercent ?? "?"
                case .failure:
                    fat = "?"
                }
            }
        }
        .padding()
        .background(
            Rectangle()
                .fill(Color(uiColor: .gray.withAlphaComponent(0.1)))
                .cornerRadius(8)
        )
        .padding()
    }
}

#Preview {
    WeightFatView(healthService: HealthService.shared)
}
