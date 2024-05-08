//
//  Test.swift
//  Everyday
//
//  Created by Михаил on 24.04.2024.
//

import SwiftUI

struct ProfileAcknowledgementView: View {
    
    // MARK: - properties
    @StateObject private var viewModel = ProfileAcknowledgementViewModel()
    @State private var selectedAge: Age = .small
    @State private var selectedGender: Gender = .male
    @State private var selectedWeight = ""
    @State private var selectedName = ""
    @State private var selectedSurname = ""
    @State private var selectedNickname = ""
    @State private var isLoading = false
    @State private var update: Bool = false
    
    var authType: String
    var onFinish: (() -> Void)?
    
    // MARK: - body
    
    var body: some View {
        ScrollView {
            VStack(spacing: Constants.VStackValues.spacing) {
                if isLoading {
                    ProgressView()
                } else {
                    content
                }
                
                if viewModel.showingAlert {
                    AlertViewControllerWrapper(isPresented: $viewModel.showingAlert, alertType: viewModel.alertType ?? .unknownRegistrationError)
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $viewModel.showingImagePicker, onDismiss: viewModel.loadImage) {
                ImagePicker(image: self.$viewModel.inputImage)
            }
        }
        .scrollIndicators(.hidden)
        .onAppear {
            loadInitialData()
        }
    }
    
    // MARK: - content
    
    var content: some View {
        Group {
            Spacer()
            Text(AttributedString(viewModel.title))
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(Constants.primaryText)
            Spacer()
            
            profileImageView
            
            Button(action: {
                viewModel.showingImagePicker = true
            }, label: {
                Text(AttributedString(viewModel.photoTitle))
                    .foregroundColor(Constants.primaryText)
            })

            Spacer()
            
            userTextFields

            Spacer()
            
            Text(AttributedString(viewModel.ageConfirm))
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.primaryText)

            ForEach(viewModel.ages, id: \.self) { age in
                let ageText = viewModel.ageText(for: age)
                AgeButtonView(age: age, ageText: ageText, selectedAge: $selectedAge )
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
                    selectedGender: $selectedGender
                )
            }

            Spacer()

            Text(AttributedString(viewModel.weightConfirm))
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.primaryText)

            DecimalTextField(text: $selectedWeight, keyType: .numberPad, placeholder: viewModel.placeholder, selectedSegmentIndex: 0)
                .frame(width: Constants.TextFieldValues.size.width, height: Constants.TextFieldValues.size.height)
                .padding(.horizontal, Constants.TextFieldValues.hPadding)
                .background(Color.gray.opacity(Constants.TextFieldValues.colorOpacity))
                .cornerRadius(Constants.TextFieldValues.cornerRadius)

            Spacer()
          
            Button(action: {
                submitAction()
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
    }
    
    // MARK: - content views
    
    private var profileImageView: some View {
        ZStack {
            if let inputImage = viewModel.inputImage {
                Image(uiImage: inputImage)
                    .resizable()
            }
        }
        .scaledToFill()
        .frame(width: Constants.ZStackValues.size.width, height: Constants.ZStackValues.size.height)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.primary, lineWidth: Constants.ZStackValues.overlay))
        .padding()
    }
    
     private var userTextFields: some View {
        Group {
            UserTextField(text: $selectedName,
                          keyType: .default,
                          placeholder: viewModel.name,
                          validationType: .name,
                          onValidation: { isValid in
                if !isValid {
                    setAlert(alertType: .onBoardingNameMessage)
                    update = false
                    ProfileAcknowledgementModel.shared.clear(fields: [.firstname])
                } else {
                    update = true
                    ProfileAcknowledgementModel.shared.update(firstname: viewModel.name)
                }
            })

            UserTextField(text: $selectedSurname,
                          keyType: .default,
                          placeholder: viewModel.surname,
                          validationType: .lastname,
                          onValidation: { isValid in
                if !isValid {
                    setAlert(alertType: .onBoardingSurnameMessage)
                    update = false
                    ProfileAcknowledgementModel.shared.clear(fields: [.lastname])
                } else {
                    update = true
                    ProfileAcknowledgementModel.shared.update(nickname: viewModel.surname)
                }
            })

            UserTextField(text: $selectedNickname,
                          keyType: .default,
                          placeholder: viewModel.nickname,
                          validationType: .username,
                          onValidation: { isValid in
                if !isValid {
                    setAlert(alertType: .onBoardingNicknameMessage)
                    update = false
                    ProfileAcknowledgementModel.shared.clear(fields: [.nickname])
                } else {
                    update = true
                    ProfileAcknowledgementModel.shared.update(nickname: viewModel.nickname)
                }
            })
        }
        .frame(width: Constants.TextFieldValues.size.width, height: Constants.TextFieldValues.size.height)
        .padding(.horizontal, Constants.TextFieldValues.hPadding)
        .background(Constants.gray.opacity(Constants.TextFieldValues.colorOpacity))
        .cornerRadius(Constants.TextFieldValues.cornerRadius)
    }
    
    // MARK: - private functions
    
    private func submitAction() {
        isLoading = true
        saveDataToModel()
        
        AuthService.shared.authWithFirebase(with: ProfileAcknowledgementModel.shared) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.isLoading = false
                    
                    let key = authType + "Auth"
                    KeychainService.saveString(authType, for: key)
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    Reloader.shared.getAuthType()
                    
                    self.onFinish?()
                }
            case .failure(let error):
                setAlert(alertType: .networkMessage(error: error))
                
                 DispatchQueue.main.async {
                    self.onFinish?()
                }
            }
        }
    }
    
    private func loadInitialData() {
        selectedAge = Age.from(description: ProfileAcknowledgementModel.shared.age ?? "") ?? .small
        selectedGender = Gender.from(description: ProfileAcknowledgementModel.shared.gender ?? "") ?? .male
        selectedWeight = ProfileAcknowledgementModel.shared.weight ?? ""
        selectedName = ProfileAcknowledgementModel.shared.firstname ?? ""
        selectedSurname = ProfileAcknowledgementModel.shared.lastname ?? ""
        selectedNickname = ProfileAcknowledgementModel.shared.nickname ?? ""
        viewModel.inputImage = ProfileAcknowledgementModel.shared.profileImage
    }
    
    private func saveDataToModel() {
        ProfileAcknowledgementModel.shared.update(firstname: selectedName, lastname: selectedSurname,
                                                  nickname: selectedNickname, profileImage: viewModel.inputImage,
                                                  age: selectedAge.description, gender: selectedGender.description,
                                                  weight: selectedWeight)
    }
    
    private func setAlert(alertType: AlertType) {
        viewModel.alertType = alertType
        
        switch alertType {
        case .onBoardingNameMessage:
            selectedName = ""
        case .onBoardingNicknameMessage:
            selectedNickname = ""
        case .onBoardingSurnameMessage:
            selectedSurname = ""
        default:
            break
        }
        
        viewModel.showingAlert = true
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
