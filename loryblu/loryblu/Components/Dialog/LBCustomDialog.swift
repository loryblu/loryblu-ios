import SwiftUI

struct LBCustomDialog<Content> : View where Content : View {
    let dismiss: () -> Void
    let content: () -> Content
    init(dismiss: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.dismiss = dismiss
        self.content = content
    }
    @State private var offset: CGFloat = 1000
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
                .onTapGesture {
                    dismiss()
                }
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
