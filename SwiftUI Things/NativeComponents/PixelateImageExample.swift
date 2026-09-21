import SwiftUI
import CoreImage
import iOS26Macros

extension PixelateImageExample: NativeComponentThing {
    static let title = "Pixelate image"
    static func makeView() -> some View { Self() }
}

struct PixelateImageExample: View {

    private let sourceImage = UIImage(resource: .sonoma)
    
    private func pixelateImage(scale: CGFloat) -> UIImage? {
        let context = CIContext()
        let inputCIImage = CIImage(image: sourceImage)

        guard let filter = CIFilter(name: "CIPixellate") else {
            return nil
        }

        filter.setValue(inputCIImage, forKey: kCIInputImageKey)
        filter.setValue(scale, forKey: kCIInputScaleKey)

        guard let outputImage = filter.outputImage,
              let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }

    var body: some View {
        let (preview, code) = #CodeSnippet(
            VStack(spacing: 20) {
                Image(uiImage: UIImage(resource: .sonoma))
                    .resizable()
                    .scaledToFit()

                if let uiImage = pixelateImage(scale: 20) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
            }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Component", icon: "square.3.layers.3d"),
            ],
            description: "Applies the Core Image CIPixellate filter to an image to produce a retro mosaic/pixelated effect.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    PixelateImageExample()
}
