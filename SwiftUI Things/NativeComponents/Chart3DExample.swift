import SwiftUI
import Charts
import iOS26Macros

extension Chart3DExample: NativeComponentThing {
    static let title = "Chart 3D"
    static func makeView() -> some View { Self() }
}

struct Chart3DExample: View {

    private static let data = (0..<200).map { _ in
        (
            x: Double.random(in: 0...50),
            y: Double.random(in: 0...100),
            z: Double.random(in: 0...100)
        )
    }

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Chart3D(Self.data, id: \.x) { point in
                PointMark(
                    x: .value("X", point.x),
                    y: .value("Y", point.y),
                    z: .value("Z", point.z)
                )
            }
            .frame(height: 700)
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Component", icon: "square.3.layers.3d"),
                .init(title: "iOS 26+"),
            ],
            description: "A 3D scatter chart built with Chart3D, plotting 200 random points along the x, y, and z axes.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    Chart3DExample()
}