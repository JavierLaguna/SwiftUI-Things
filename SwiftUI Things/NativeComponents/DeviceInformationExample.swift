import SwiftUI
import iOS26Macros

extension DeviceInformationExample: NativeComponentThing {
    static let title = "Device information"
    static func makeView() -> some View { Self() }
}

struct DeviceInformationExample: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Section("Device Info") {
                LabeledContent("System Name", value: UIDevice.current.systemName)
                LabeledContent("System Version", value: UIDevice.current.systemVersion)
                LabeledContent("Device Model", value: UIDevice.current.model)
                LabeledContent("Device Name", value: UIDevice.current.name)
            }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(
                    title: "Native Component",
                    icon: "square.3.layers.3d"
                ),
            ],
            description: "Displays device information using LabeledContent, including system name, version, model, and device name.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    DeviceInformationExample()
}
