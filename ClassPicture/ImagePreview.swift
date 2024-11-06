import SwiftUI

struct ImagePreview: View {
    var image: UIImage
    @State private var scale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        VStack {
            Spacer()

            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
                .offset(x: offset.width + dragOffset.width, y: offset.height + dragOffset.height)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            let delta = value / self.lastScaleValue
                            self.lastScaleValue = value
                            self.scale *= delta
                        }
                        .onEnded { _ in
                            self.lastScaleValue = 1.0
                        }
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.dragOffset = value.translation
                        }
                        .onEnded { value in
                            self.offset.width += value.translation.width
                            self.offset.height += value.translation.height
                            self.dragOffset = .zero
                        }
                )
                .gesture(
                    TapGesture(count: 2)
                        .onEnded {
                            if scale > 1 {
                                scale = 1
                                offset = .zero
                            } else {
                                scale = 3
                                offset = .zero
                            }
                        }
                )
                .background(Color.black)

            Spacer()
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}
