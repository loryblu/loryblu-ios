import SwiftUI

struct LBCustomDialog<Content> : View where Content : View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
            self.content = content
    }

    @State private var offset: CGFloat = 1000
    
    var body: some View {
        ZStack {
            VStack {
                content()
            }
            .padding(16)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(LBColor.textfield)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 8)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
    }
}
