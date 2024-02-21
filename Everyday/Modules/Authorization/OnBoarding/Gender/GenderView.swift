import SwiftUI

// MARK: - GenderView

struct GenderView: View {
    
    // MARK: - Properties
    
    @StateObject var controller = GenderViewController()
    let viewModel = GenderViewModel() 
    var onNext: () -> Void
    
    // MARK: - Body

    var body: some View {
        VStack(spacing: Constants.VStackValues.spacing) {
            Spacer()
            
            Text(AttributedString(viewModel.title))
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(Constants.primaryText)
                        
            ForEach(viewModel.gendersUI, id: \.gender) { genderUI in
                GenderButtonView(
                    gender: genderUI.gender,
                    imageName: genderUI.imageName,
                    localizedText: genderUI.localizedText,
                    selectedGender: $controller.selectedGender
                )
            }
            
            Spacer()
            
            Button(action: {
                onNext()
            }, label: {
                Text(AttributedString(viewModel.next))
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

private extension GenderView {
    struct Constants {
        
        static let primaryText = Color.primaryText
        static let accent = Color.accent
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
