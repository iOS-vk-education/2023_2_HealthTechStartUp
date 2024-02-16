//
//  AgeButtonView.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import SwiftUI

// MARK: - AgeButtonView

struct AgeButtonView: View {
    
    // MARK: - Properties
    
    let age: Age
    let ageText: String
    @Binding var selectedAge: Age
    
    // MARK: - Body
        
    var body: some View {
        Button(action: {
            self.selectedAge = age
        }, label: {
            HStack {
                Text(ageText)
                    .foregroundColor(.black)
                
                Spacer()
                
                Circle()
                    .strokeBorder(Constants.accent, lineWidth: Constants.CircleValues.lineWidth)
                    .background(Circle().fill(selectedAge == age ? Constants.accent : Constants.clear))
                    .frame(width: Constants.CircleValues.size.width, height: Constants.CircleValues.size.height)
            }
            .padding()
            .background(Constants.gray.opacity(Constants.ButtonValues.colorOpacity))
            .cornerRadius(Constants.ButtonValues.cornerRadius)
        })
        .padding(.horizontal, Constants.ViewValues.hPadding)
    }
}

// MARK: - extensions

private extension AgeButtonView {
    
    struct Constants {
        
        static let primaryText = Color.primaryText
        static let accent = Color.accent
        static let clear = Color.clear
        static let gray = Color.gray
        
        struct ViewValues {
            static let hPadding: CGFloat = 8
        }
        
        struct ButtonValues {
            static let colorOpacity: CGFloat = 0.1
            static let cornerRadius: CGFloat = 10
        }
        
        struct CircleValues {
            static let lineWidth: CGFloat = 1
            static let size: CGSize = CGSize(width: 20, height: 20)
        }
    }
}
