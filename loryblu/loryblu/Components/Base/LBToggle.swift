import SwiftUI

struct LBToggle: View {
    @Binding var isActived: Bool

    var body: some View {
        Button {
            isActived.toggle()
        } label: {
            if isActived {
                LBIcon.circleFill.image
            } else {
                LBIcon.circle.image
            }
        }
        .frame(width: 12, height: 12)

    }
}

struct LBToggle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LBToggle(isActived: .constant(false))
            LBToggle(isActived: .constant(true))
        }
    }
}
