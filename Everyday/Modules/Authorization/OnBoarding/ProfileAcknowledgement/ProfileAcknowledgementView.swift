import SwiftUI
// MARK: - ProfileSetupView

struct ProfileAcknowledgementView: View {
    
    // MARK: - properties
    
    @StateObject private var viewModel = ProfileAcknowledgementViewModel()
    @StateObject var controller = ProfileAcknowledgementController()
    
    @State private var weight: String = ""
    private let defaultImage = Image("anonymous")
    
    var onFinish: (() -> Void)?
    
    // MARK: - body
    
    var body: some View {
        ScrollView {
            VStack(spacing: Constants.VStackValues.spacing) {
                Spacer()
                
                Text(AttributedString(viewModel.title))
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Constants.primaryText)
                
                Spacer()
                
                ZStack {
                    if let inputImage = viewModel.inputImage {
                        Image(uiImage: inputImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        defaultImage
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: Constants.ZStackValues.size.width, height: Constants.ZStackValues.size.height)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.primary, lineWidth: Constants.ZStackValues.overlay))
                .padding()
                
                Button(action: {
                    viewModel.showingImagePicker = true
                }, label: {
                    Text(AttributedString(viewModel.photoTitle))
                        .foregroundColor(Constants.primaryText)
                })

                Spacer()
                
                UserTextField(text: $viewModel.userProfile.name, keyType: .default, placeholder: viewModel.name)
                    .frame(width: Constants.TextFieldValues.size.width, height: Constants.TextFieldValues.size.height)
                    .padding(.horizontal, Constants.TextFieldValues.hPadding)
                    .background(Constants.gray.opacity(Constants.TextFieldValues.colorOpacity))
                    .cornerRadius(Constants.TextFieldValues.cornerRadius)
                
                UserTextField(text: $viewModel.userProfile.surname, keyType: .default, placeholder: viewModel.surname)
                    .frame(width: Constants.TextFieldValues.size.width, height: Constants.TextFieldValues.size.height)
                    .padding(.horizontal, Constants.TextFieldValues.hPadding)
                    .background(Constants.gray.opacity(Constants.TextFieldValues.colorOpacity))
                    .cornerRadius(Constants.TextFieldValues.cornerRadius)
                
                UserTextField(text: $viewModel.userProfile.nickname, keyType: .default, placeholder: viewModel.nickname)
                    .frame(width: Constants.TextFieldValues.size.width, height: Constants.TextFieldValues.size.height)
                    .padding(.horizontal, Constants.TextFieldValues.hPadding)
                    .background(Constants.gray.opacity(Constants.TextFieldValues.colorOpacity))
                    .cornerRadius(Constants.TextFieldValues.cornerRadius)
                
                Spacer()
                
                Text(AttributedString(viewModel.ageConfirm))
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.primaryText)
                            
                ForEach(controller.ages, id: \.self) { age in
                    let ageText = viewModel.ageText(for: age)
                    AgeButtonView(age: age, ageText: ageText, selectedAge: $controller.selectedAge)
                }
                
                Spacer()
                
                Text(AttributedString(viewModel.genderConfirm))
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
                
                Text(AttributedString(viewModel.weightConfirm))
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
                    onFinish?()
                                }, label: {
                                    Text(AttributedString(viewModel.starter))
                                        .padding(.horizontal, Constants.ButtonValues.hPadding)
                                        .padding(.vertical, Constants.ButtonValues.vPadding)
                                        .frame(maxWidth: .infinity)
                                        .background(Constants.accent)
                                        .foregroundColor(Constants.button)
                                        .cornerRadius(Constants.ButtonValues.cornerRadius)
                                })

                .padding(.bottom, Constants.VStackValues.bPadding)
            }
            .padding(.horizontal)
            .sheet(isPresented: $viewModel.showingImagePicker, onDismiss: viewModel.loadImage) {
                ImagePicker(image: self.$viewModel.inputImage)
            }
        }
        .scrollIndicators(.hidden)
    }
}

// MARK: - extensions

private extension ProfileAcknowledgementView {
    struct Constants {
        
        static let primaryText = Color.primaryText
        static let accent = Color.accent
        static let clear = Color.clear
        static let gray = Color.gray
        static let button = Color.grayElement
        
        struct VStackValues {
            static let spacing: CGFloat = 15
            static let bPadding: CGFloat = 65
        }
        
        struct ZStackValues {
            static let size: CGSize = CGSize(width: 150, height: 150)
            static let overlay: CGFloat = 0.5
        }
        
        struct ButtonValues {
            static let hPadding: CGFloat = 100
            static let vPadding: CGFloat = 16
            static let cornerRadius: CGFloat = 20
        }
        
        struct TextFieldValues {
            static let size: CGSize = CGSize(width: 300, height: 50)
            static let hPadding: CGFloat = 24
            static let cornerRadius: CGFloat = 8
            static let colorOpacity: CGFloat = 0.1
        }
    }
}

#Preview {
    ProfileAcknowledgementView()
}
