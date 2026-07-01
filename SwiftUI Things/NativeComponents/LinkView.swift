import SwiftUI
import iOS26Macros

extension LinkView: NativeComponentThing {
    static let title = "LinkView"
    static func makeView() -> some View { Self() }
}

struct LinkView: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            VStack(spacing: 30) {
                Link("Go to Apple", destination: URL(string: "https://apple.com")!)

                Link("Go to Apple", destination: URL(string: "https://apple.com")!)
                    .buttonStyle(.borderless)

                Link("Call To Action", destination: URL(string: "tel:1234567890")!)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .controlSize(.regular)

                Link("Send an Email", destination: URL(string: "mailto:swiftui@apple.com")!)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.large)
                    .tint(.pink)

                Link("Credo Academy", destination: URL(string: "https://credo.academy")!)
                    .buttonStyle(.plain)
                    .padding()
                    .border(.primary, width: 2)

                Link(destination: URL(string: "https://apple.com")!) {
                    HStack(spacing: 16) {
                        Image(systemName: "apple.logo")
                        Text("Apple Store")
                    }
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background (
                        Capsule()
                            .fill(Color.blue)
                    )
                }
            }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Component", icon: "square.3.layers.3d"),
            ],
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    LinkView()
}
