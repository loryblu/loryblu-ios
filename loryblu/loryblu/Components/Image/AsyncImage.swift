import SwiftUI

struct AsyncImage : View {
    @StateObject private var loader: ImageLoader

    init(url: String) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        Group {
            Image(uiImage: loader.image!)
                .resizable()
        }
    }
}
