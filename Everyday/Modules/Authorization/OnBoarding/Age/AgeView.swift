//
//  AgeView.swift
//  welcome
//
//  Created by Михаил on 14.02.2024.
//

import SwiftUI

// MARK: - AgeView

struct AgeView: View {
    
    // MARK: - Properties
    
    @StateObject var controller = AgeViewController()
    let viewModel = AgeViewModel()
    var onNext: () -> Void
    
    // MARK: - Body

    var body: some View {
        VStack(spacing: Constants.VStackValues.spacing) {
            Spacer()
            
            Text(AttributedString(viewModel.title))
                .font(.headline)
                .multilineTextAlignment(.center)
                        
            ForEach(controller.ages, id: \.self) { age in
                let ageText = ageText(for: age)
                AgeButtonView(age: age, ageText: ageText, selectedAge: $controller.selectedAge)
            }
            
            Spacer()
            
            Button(action: {
                onNext()
            }, label: {
                Text(AttributedString((viewModel.next)))
                    .padding(.horizontal, Constants.ButtonValues.hPadding)
                    .padding(.vertical, Constants.ButtonValues.vPadding)
                    .frame(maxWidth: .infinity)
                    .background(Constants.accent)
                    .foregroundColor(Constants.button)
                    .cornerRadius(Constants.ButtonValues.cornerRadius)
            })

            Button(action: {
                onNext()
            }, label: {
                Text(AttributedString((viewModel.skip)))
                    .background(Constants.clear)
                    .foregroundColor(Constants.primaryText)
                    .cornerRadius(Constants.ButtonValues.cornerRadius)
            })
            
            .padding(.bottom, Constants.VStackValues.bPadding)
        }
        .padding(.horizontal)
        .onChange(of: controller.selectedAge) { newValue in
            let selectedAgeData = AgeData(age: newValue)
            ProfileAcknowledgementModel.shared.update(age: selectedAgeData.age.description)
        }
    }
    private func ageText(for age: Age) -> String {
        switch age {
        case .small: return "17 - 24"
        case .young: return "25 - 34"
        case .adult: return "35 - 54"
        case .old: return "55+"
        }
    }
}

// MARK: - Constants

private extension AgeView {
    struct Constants {
        
        static let primaryText = Color.primaryText
        static let accent = Color.accent
        static let clear = Color.clear
        static let button = Color.grayElement
        
        struct VStackValues {
            static let spacing: CGFloat = 15
            static let bPadding: CGFloat = 65
        }
        
        struct ButtonValues {
            static let hPadding: CGFloat = 100
            static let vPadding: CGFloat = 16
            static let cornerRadius: CGFloat = 20
        }
    }
}
