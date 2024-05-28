import SwiftUI

struct LBRadioButton<Content> : View where Content : View  {
    @Binding var isSelected: Bool
    let content: () -> Content
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
           circleView
           content()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isSelected = true
        }
    }
}

extension LBRadioButton {
  var circleView: some View {
     Circle()
       .fill(innerCircleColor)
       .padding(4)
       .overlay(
          Circle()
            .stroke(outlineColor, lineWidth: 1)
        )
       .frame(width: 20, height: 20)
  }
}
private extension LBRadioButton {
   var innerCircleColor: Color {
       return isSelected ? LBColor.buttonPrimary : Color.clear
   }

   var outlineColor: Color {
       return isSelected ? LBColor.buttonPrimary : Color.gray
   }
}
extension LBRadioButton {
   // To support multiple options
    init<V: Hashable>(tag: V, selection: Binding<V?>, @ViewBuilder content: @escaping () -> Content) {
      self._isSelected = Binding(
        get: { selection.wrappedValue == tag },
        set: { _ in selection.wrappedValue = tag }
      )
      self.content = content
    }
}

#Preview {
    LBRadioButton(isSelected: Binding.constant(false), content: { 
        Text("Placeholder")
    })
}
