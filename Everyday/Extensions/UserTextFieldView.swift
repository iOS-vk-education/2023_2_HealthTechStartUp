//
//  TextFieldView.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import SwiftUI

enum ValidationType {
    case username
    case name
    case lastname
    case none
}

struct UserTextField: UIViewRepresentable {
    @Binding var text: String
    var keyType: UIKeyboardType
    var placeholder: String
    var validationType: ValidationType
    var onValidation: ((Bool) -> Void)?

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = keyType
        textField.placeholder = placeholder
        textField.textColor = UIColor.Text.primary
        textField.tintColor = UIColor.UI.accent

        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "keyboard_toolbar_ready_title".localized, 
                                         style: .done,
                                         target: context.coordinator, action: #selector(context.coordinator.dismissKeyboard))
        doneButton.tintColor = UIColor.white
        
        _ = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton], animated: true)

        textField.inputAccessoryView = toolbar
        textField.delegate = context.coordinator

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: UserTextField

        init(_ textField: UserTextField) {
            self.parent = textField
        }

        @objc func dismissKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            switch parent.validationType {
            case .username:
                let isValid = Validator.isValidUsername(for: textField.text ?? "")
                parent.onValidation?(isValid)
            case .name:
                let isValid = Validator.isValidName(for: textField.text ?? "")
                parent.onValidation?(isValid)
            case .lastname:
                let isValid = Validator.isValidSurname(for: textField.text ?? "")
                parent.onValidation?(isValid)
            case .none:
                break
            }
        }
    }
}
