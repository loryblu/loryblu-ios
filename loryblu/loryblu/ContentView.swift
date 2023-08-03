import SwiftUI

struct ContentView: View {
    var body: some View {

        VStack {
            LBIcon.loryblu.image
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
            Text(LBStrings.General.hello)
                .font(LBFont.head2)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
