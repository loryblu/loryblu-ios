import SwiftUI

struct MenuWebView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var title: String
    @Binding var urlString: String

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(title)
                    .font(LBFont.bodyLarge.bold())
                    .padding()

                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(LBIcon.close3.rawValue)
                }
            }
            .padding()

            WebView(url: URL(string: urlString)!)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.bottom)

    }
}

struct MenuWebView_Previews: PreviewProvider {
    @State static var title = "Título do Menu"
    @State static var urlString = "https://exemplo.com"

    static var previews: some View {
        MenuWebView(title: $title, urlString: $urlString)
    }
}
