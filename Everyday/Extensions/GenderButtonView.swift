//
//  GenderButtonView.swift
//  welcome
//
//  Created by Михаил on 14.02.2024.
//

import SwiftUI

struct GenderButtonView: View {
    let gender: Gender
    let imageName: String
    let localizedText: String
    @Binding var selectedGender: Gender
    
    var body: some View {
        Button(action: {
            self.selectedGender = gender
        }, label: {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.ImageValues.size.width, height: Constants.ImageValues.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.ImageValues.cornerRadius))
                    .padding(.trailing, Constants.ImageValues.tPadding)

                Text(localizedText)
                    .foregroundColor(.black)
                
                Spacer()
                
                Circle()
                    .strokeBorder(Constants.accent, lineWidth: Constants.CircleValues.lineWidth)
                    .background(Circle().fill(selectedGender == gender ? Constants.accent : Constants.clear))
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

private extension GenderButtonView {
    
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
        
        struct ImageValues {
            static let size: CGSize = CGSize(width: 30, height: 30)
            static let cornerRadius: CGFloat = 6
            static let tPadding: CGFloat = 16
        }
        
        struct CircleValues {
            static let lineWidth: CGFloat = 1
            static let size: CGSize = CGSize(width: 20, height: 20)
        }
    }
}
