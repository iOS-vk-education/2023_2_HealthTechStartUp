import SwiftUI

// MARK: - WeightView

struct WeightView: View {
    
    // MARK: - Properties
    
    let viewModel = WeightViewModel()
    @State private var weight: String = ""
    var onNext: () -> Void
    
    // MARK: - Body

    var body: some View {
        VStack(spacing: Constants.VStackValues.spacing) {
            Spacer()
            
            Text(AttributedString(viewModel.title))
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.primaryText)
         
            DecimalTextField(text: $weight, keyType: .numberPad, placeholder: viewModel.placeholder)
                .frame(width: Constants.TextFieldValues.size.width, height: Constants.TextFieldValues.size.height)
                .padding(.horizontal, Constants.TextFieldValues.hPadding)
                .background(Color.gray.opacity(Constants.TextFieldValues.colorOpacity))
                .cornerRadius(Constants.TextFieldValues.cornerRadius)

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
    }
}

// MARK: - extensions

private extension WeightView {
    
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
        
        struct TextFieldValues {
            static let size: CGSize = CGSize(width: 240, height: 56)
            static let hPadding: CGFloat = 24
            static let cornerRadius: CGFloat = 8
            static let colorOpacity: CGFloat = 0.1
        }
    }    
}
