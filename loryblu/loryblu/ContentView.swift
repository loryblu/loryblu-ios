import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            LBIcon.loryblu.image
            Text(LBStrings.General.hello)
                .font(LBFont.head2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
