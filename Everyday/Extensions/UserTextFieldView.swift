//
//  TextFieldView.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import SwiftUI

struct UserTextField: UIViewRepresentable {
    @Binding var text: String
    var keyType: UIKeyboardType
    var placeholder: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = keyType
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Text.primary]
        )
        textField.textColor = UIColor.Text.primary
        textField.tintColor = UIColor.UI.accent

        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "ready".localized, 
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
    }
}
