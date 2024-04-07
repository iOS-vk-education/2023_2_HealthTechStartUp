//
//  PhotoView.swift
//  welcome
//
//  Created by Михаил on 14.02.2024.
//

import SwiftUI

// MARK: - ProfileSetupView

struct ProfileSetupView: View {

    // MARK: - properties

    @StateObject private var viewModel = ProfileSetupViewModel()
    var onNext: () -> Void
    @State private var update: Bool = false

    // MARK: - body

    var body: some View {
        ScrollView {
            VStack(spacing: Constants.VStackValues.spacing) {
                Spacer()

                Text(AttributedString(viewModel.title))
                    .font(.headline)
                    .multilineTextAlignment(.center)

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
                .padding(.bottom, Constants.VStackValues.bPadding)
            }
            .padding(.horizontal)
            .sheet(isPresented: $viewModel.showingImagePicker, onDismiss: viewModel.loadImage) {
                ImagePicker(image: self.$viewModel.inputImage)
            }
            .onAppear {
                viewModel.inputImage = ProfileAcknowledgementModel.shared.profileImage ?? UIImage(named: viewModel.image)
            }
        }
        .scrollIndicators(.hidden)
    }
    
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
        .onChange(of: viewModel.inputImage) { _, newValue in
            ProfileAcknowledgementModel.shared.update(profileImage: newValue)
        }
    }
    
    private var userTextFields: some View {
            Group {
                UserTextField(text: $viewModel.userProfile.name,
                              keyType: .default,
                              placeholder: viewModel.name,
                              validationType: .name,
                              onValidation: { isValid in
                    if !isValid {
                        viewModel.chooseAlert = .name
                        viewModel.setAlert()
                        update = false
                        ProfileAcknowledgementModel.shared.clear(fields: [.firstname])
                    } else {
                        update = true
                        ProfileAcknowledgementModel.shared.update(firstname: $viewModel.userProfile.name.wrappedValue)
                    }
                })
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text(viewModel.nameAlertTitle),
                          message: Text(viewModel.nameAlertMessage),
                          dismissButton: .default(Text(AttributedString(viewModel.alertTitle))))
                }
                
                UserTextField(text: $viewModel.userProfile.surname,
                              keyType: .default,
                              placeholder: viewModel.surname,
                              validationType: .lastname,
                              onValidation: { isValid in
                    if !isValid {
                        viewModel.chooseAlert = .surname
                        viewModel.setAlert()
                        update = false
                        ProfileAcknowledgementModel.shared.clear(fields: [.lastname])
                    } else {
                        update = true
                        ProfileAcknowledgementModel.shared.update(lastname: $viewModel.userProfile.surname.wrappedValue)
                    }
                  })
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text(viewModel.surnameAlertTitle),
                          message: Text(viewModel.surnameAlertMessage),
                          dismissButton: .default(Text(AttributedString(viewModel.alertTitle))))
                }
                
                UserTextField(text: $viewModel.userProfile.nickname,
                              keyType: .default,
                              placeholder: viewModel.nickname,
                              validationType: .username,
                              onValidation: { isValid in
                    if !isValid {
                        viewModel.chooseAlert = .nickname
                        viewModel.setAlert()
                        update = false
                        ProfileAcknowledgementModel.shared.clear(fields: [.nickname])
                    } else {
                        update = true
                        ProfileAcknowledgementModel.shared.update(nickname: $viewModel.userProfile.nickname.wrappedValue)
                    }
                })
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text(viewModel.nicknameAlertTitle),
                          message: Text(viewModel.nicknameAlertMessage),
                          dismissButton: .default(Text(AttributedString(viewModel.alertTitle))))
                }
            }
            .frame(width: Constants.TextFieldValues.size.width, height: Constants.TextFieldValues.size.height)
            .padding(.horizontal, Constants.TextFieldValues.hPadding)
            .background(Constants.gray.opacity(Constants.TextFieldValues.colorOpacity))
            .cornerRadius(Constants.TextFieldValues.cornerRadius)
        }
}

// MARK: - extensions

private extension ProfileSetupView {
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
