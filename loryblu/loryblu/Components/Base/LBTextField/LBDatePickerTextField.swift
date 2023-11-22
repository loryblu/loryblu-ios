import SwiftUI

enum DatepickeSelect: Hashable {
    case datepicker
}

struct LBDatePickerTextField: View {
    enum DatePickerState: CGFloat, Equatable {
        case active = 0
        case alert = 2
    }

    let icon: LBIcon?
    let title: String
    @Binding var date: Date?

    @State private var formatDate: String = ""
    @FocusState private var focusedTextField: DatepickeSelect?
    let state: DatePickerState

    var body: some View {

        HStack {
            HStack {
                if let icon = icon {
                    icon.image.frame(width: 22)
                }
                TextField(title, text: $formatDate)
                    .focused($focusedTextField,equals: .datepicker)
            }
            .padding()
            .foregroundColor(LBColor.placeholder)
            .font(LBFont.bodySmall)
            .onChange(of: date) { newValue in
                if let newValue {
                    self.formatDate = Formatter.dateFormatter.string(from: newValue)
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

struct LBDatePickerTextField_Previews: PreviewProvider {
    static var previews: some View {
          ZStack {
              LBDatePickerTextField(icon: .google, title: "Data de Aniversário", date: .constant(Date()), state: .active)
        }
    }
}
