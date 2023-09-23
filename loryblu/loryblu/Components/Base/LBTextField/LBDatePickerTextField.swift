import Foundation
import SwiftUI

struct LBDatePickerTextField: UIViewRepresentable {
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()

    public var placeholder: String
    @Binding public var date: Date?

    func makeUIView(context: Context) -> UITextField {
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "pt")
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self.helper, action: #selector(self.helper.dateValueChanged), for: .valueChanged)

        textField.placeholder = placeholder
        textField.inputView = datePicker

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            title: LBStrings.General.confirm,
            style: .plain,
            target: helper,
            action: #selector(helper.doneButtonTapped)
        )

        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar

        helper.onDateValueChanged = {
            date = datePicker.date
        }

        helper.onDoneButtonTapped = {
            if date == nil {
                date = datePicker.date
            }

            textField.resignFirstResponder()
        }

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = date {
            uiView.text = Formatter.dateFormatter.string(from: selectedDate)
        }
    }

    class Helper {
        public var onDateValueChanged: (() -> Void)?
        public var onDoneButtonTapped: (() -> Void)?

        @objc func dateValueChanged() {
            onDateValueChanged?()
        }

        @objc func doneButtonTapped() {
            onDoneButtonTapped?()
        }
    }
}
