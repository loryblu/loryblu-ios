import SwiftUI

struct ExternalLogin: View {

    var body: some View {
        HStack {
            Button {
            } label: {
                LBIcon.google.image
            }
            .padding(.trailing, 48.0)

            Button {

            } label: {
                LBIcon.facebook.image

            }

        }
    }
}

struct ExternalLogin_Previews: PreviewProvider {
    static var previews: some View {
        ExternalLogin()
    }
}
