import SwiftUI

struct LBDatePicker: View {
    enum DatePickerState: CGFloat, Equatable {
        case active = 0
        case alert = 2
    }

    let icon: LBIcon?
    let title: String
    @Binding var date: Date?

    @State private var text: String?

    let state: DatePickerState

    var body: some View {

        HStack {
            HStack {
                if let icon = icon {
                    icon.image.frame(width: 22)
                }

                LBDatePickerTextField(placeholder: title, date: $date)
                    .foregroundColor(LBColor.text)
            }
            .padding()
            .foregroundColor(LBColor.placeholder)
            .font(LBFont.bodySmall)
            .onChange(of: date) { newValue in
                if let newValue {
                    self.text = Formatter.dateFormatter.string(from: newValue)
                }
            }
        }
        .background(LBColor.textfield)
        .frame(height: 48)
        .cornerRadius(8)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 8)
            .stroke(LBColor.error, lineWidth: state.rawValue)
        })
    }
}

struct LBDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        @State var date: Date?
        @State var presented = true
        @State var text = ""

        VStack {
            LBDatePicker(icon: .google, title: "Date", date: $date, state: .active)
        }
    }
}
