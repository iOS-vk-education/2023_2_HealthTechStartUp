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
    var selectedSegmentIndex: Int

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
        segmentedControl.selectedSegmentIndex = selectedSegmentIndex
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
        
        if let segmentedControl = uiView.inputAccessoryView?.subviews.first as? UISegmentedControl {
            segmentedControl.selectedSegmentIndex = selectedSegmentIndex
        }
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
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return newText.count <= 3 && newText.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            guard let toolbar = textField.inputAccessoryView as? UIToolbar,
                  let segmentedControl = toolbar.items?.first?.customView as? UISegmentedControl else {
                return
            }
                        
            let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
            
            switch selectedSegmentIndex {
            case 0:
                ProfileAcknowledgementModel.shared.update(bodyWeightMeasureUnit: "kg")
                ProfileAcknowledgementModel.shared.update(measurementsMeasureUnit: "centimeters")
                ProfileAcknowledgementModel.shared.update(loadWeightMeasureUnit: "kg")
                ProfileAcknowledgementModel.shared.update(distanceMeasureUnit: "kilometers")
            case 1:
                ProfileAcknowledgementModel.shared.update(bodyWeightMeasureUnit: "lb")
                ProfileAcknowledgementModel.shared.update(measurementsMeasureUnit: "inches")
                ProfileAcknowledgementModel.shared.update(loadWeightMeasureUnit: "lb")
                ProfileAcknowledgementModel.shared.update(distanceMeasureUnit: "miles")
            case 2:
                ProfileAcknowledgementModel.shared.update(bodyWeightMeasureUnit: "st")
                ProfileAcknowledgementModel.shared.update(measurementsMeasureUnit: "inches")
                ProfileAcknowledgementModel.shared.update(loadWeightMeasureUnit: "st")
                ProfileAcknowledgementModel.shared.update(distanceMeasureUnit: "miles")
            default:
                break
            }
        }
    }
}
