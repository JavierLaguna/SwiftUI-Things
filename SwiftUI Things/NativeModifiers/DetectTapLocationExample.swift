import SwiftUI
import iOS26Macros

extension DetectTapLocationExample: NativeModifiersThing {
    static let title = "Detect Tap Location"
    static func makeView() -> some View { Self() }
}

struct DetectTapLocationExample: View {

    @State private var tappedLocation: CGPoint = .zero

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Color.gray.opacity(0.3)
                .frame(width: 300, height: 400)
                .overlay {
                    VStack {
                        Text("Tapped on")
                        Text("X: \(tappedLocation.x)")
                        Text("Y: \(tappedLocation.y)")
                    }
                }
                .onTapGesture { location in
                    tappedLocation = location
                    print("User tapped at coordinates \(location)")
                }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "Uses .onTapGesture with a location parameter to capture and display the X and Y coordinates of each tap on a gray rectangle.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    DetectTapLocationExample()
}
