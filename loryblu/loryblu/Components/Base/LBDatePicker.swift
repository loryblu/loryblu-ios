//
//  DatePickerTextField.swift
//  LoryBlu
//
//  Created by Rodrigo Eduardo Silva on 08/09/23.
//

import SwiftUI
struct DatePickerTextField: View {

@State private var selectedDate = Date()
@State private var isHidden = true

let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter
}()

var body: some SwiftUI.View {
    VStack(alignment: .center) {
        ZStack {

            HStack(alignment: .center) {
                Spacer()
                    .background(Color.yellow)
                if isHidden {
                    Text(selectedDate, style: .date)
                        .onTapGesture {
                        self.onExpandTapped()
                    }
                } else {
                    TextField("Date", value: $selectedDate, formatter: formatter)
                        .multilineTextAlignment(.center)
                        .fixedSize()
                }
            }
        }

        if !isHidden {
            DatePicker(
                "",
                selection: Binding(
                    get: {
                        selectedDate
                }, set: {
                    selectedDate = $0
                    UIApplication.shared.endEditing()
                }),
                displayedComponents: .date)
                .padding(.horizontal)
                .frame(width: 333)
                .datePickerStyle(.wheel)
                .labelsHidden()


        }
    }
}

private func onExpandTapped() {
    isHidden.toggle()
}
}

extension UIApplication {
func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
}

struct DatePickerTextField_Previews: PreviewProvider {
static var previews: some View {
    DatePickerTextField()
}
}
