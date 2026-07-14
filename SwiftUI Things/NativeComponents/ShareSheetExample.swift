import SwiftUI
import iOS26Macros

extension ShareSheetExample: NativeComponentThing {
    static let title = "Share sheet"
    static func makeView() -> some View { Self() }
}

struct ShareSheetExample: View {

    private func shareButton() {
        let url = URL(string: "https://developer.apple.com/xcode/swiftui/")
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)

        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Button(action: shareButton) {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.blue)
            }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Component", icon: "square.3.layers.3d"),
            ],
            description: "A button that presents the native iOS share sheet (UIActivityViewController) with a URL, allowing the user to share content through system-defined activities.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    ShareSheetExample()
}
