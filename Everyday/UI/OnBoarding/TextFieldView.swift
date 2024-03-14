//
//  TextFieldView.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import SwiftUI

struct DecimalTextField: UIViewRepresentable {
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

        let segmentItems = ["kg".localized, "pound".localized, "stone".localized]
        let segmentedControl = UISegmentedControl(items: segmentItems)
        segmentedControl.selectedSegmentIndex = 0
        let segmentBarItem = UIBarButtonItem(customView: segmentedControl)

        let doneButton = UIBarButtonItem(title: "keyboard_toolbar_ready_title".localized, 
                                         style: .done,
                                         target: context.coordinator, action: #selector(context.coordinator.dismissKeyboard))
        doneButton.tintColor = UIColor.white

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([segmentBarItem, flexSpace, doneButton], animated: true)

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
        var parent: DecimalTextField

        init(_ textField: DecimalTextField) {
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
