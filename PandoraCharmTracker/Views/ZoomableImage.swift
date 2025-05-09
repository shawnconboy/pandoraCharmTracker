import SwiftUI

struct ZoomableImage: View {
    let imageName: String
    @State private var scale: CGFloat = 1.0

    var body: some View {
        GeometryReader { geometry in
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(scale)
                .gesture(MagnificationGesture()
                    .onChanged { value in scale = value }
                    .onEnded { _ in
                        withAnimation { scale = 1.0 }
                    }
                )
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
}
