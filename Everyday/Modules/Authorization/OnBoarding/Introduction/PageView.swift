//
//  PageView.swift
//  SlidingIntroScreen
//
//  Created by Federico on 18/03/2022.
//

import SwiftUI

// MARK: - PageView

struct PageView: View {
    
    // MARK: - properties
    
    @ObservedObject var viewModel: PageViewModel
    var onNext: () -> Void
    var onSkip: () -> Void
    
    // MARK: - body

    var body: some View {
        VStack(spacing: Constants.VStackValues.spacing) {
            Spacer()
            
            Image(viewModel.page.imageUrl)
                .resizable()
                .scaledToFit()
                .padding()
                .padding()

            Text(AttributedString(viewModel.page.name))
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text(AttributedString(viewModel.page.description))
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .frame(width: Constants.TextValues.width)
            
            Spacer()
            
            Button {
                onNext()
            } label: {
                Text(AttributedString(viewModel.next))
                    .padding(.horizontal, Constants.ButtonValues.hPadding)
                    .padding(.vertical, Constants.ButtonValues.vPadding)
                    .background(Constants.accent)
                    .foregroundColor(Constants.button)
                    .cornerRadius(Constants.ButtonValues.cornerRadius)
            }
            
            Button(action: {
                onSkip()
            }, label: {
                Text(AttributedString(viewModel.skip))
                    .background(Color.clear)
                    .foregroundColor(Color.primaryText)
                    .cornerRadius(Constants.ButtonValues.cornerRadius)
            })

            .padding(.bottom, Constants.VStackValues.bPadding)
        }
        .padding(.horizontal)
    }
}

// MARK: - extensions

private extension PageView {
    struct Constants {
        
        static let primaryText = Color.primaryText
        static let accent = Color.accent
        static let clear = Color.clear
        static let gray = Color.gray
        static let button = Color.grayElement
        
        struct VStackValues {
            static let spacing: CGFloat = 10
            static let bPadding: CGFloat = 65
        }
        
        struct ImageValues {
            static let fCornerRadius: CGFloat = 30
            static let sCornerRadius: CGFloat = 10
            static let colorOpacity: CGFloat = 0.1
        }
        
        struct TextValues {
            static let size: CGSize = CGSize(width: 150, height: 150)
            static let overlay: CGFloat = 0.5
            static let width: CGFloat = 300
        }
        
        struct ButtonValues {
            static let hPadding: CGFloat = 140
            static let vPadding: CGFloat = 16
            static let bPadding: CGFloat = 65
            static let cornerRadius: CGFloat = 20
        }
    }
}
