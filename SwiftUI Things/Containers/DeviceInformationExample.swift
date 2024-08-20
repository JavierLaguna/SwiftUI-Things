import SwiftUI

struct DeviceInformationExample: View {
    
    var body: some View {
        Form {
            Section("Device Info") {
                LabeledContent("System Name", value: UIDevice.current.systemName)
                LabeledContent("System Version", value: UIDevice.current.systemVersion)
                LabeledContent("Device Model", value: UIDevice.current.model)
                LabeledContent("Device Name", value: UIDevice.current.name)
            }
        }
    }
}

#Preview {
    DeviceInformationExample()
}
