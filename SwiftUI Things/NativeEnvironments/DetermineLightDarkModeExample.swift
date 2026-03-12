import SwiftUI

extension DetermineLightDarkModeExample: NativeEnvironmentThing {
    static let title = "Determine Light or DarkMode"
    static func makeView() -> some View { Self() }
}

struct DetermineLightDarkModeExample: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Text(colorScheme == .dark ? "Dark Mode" : "Light Mode")
            .font(.system(size: 100))
    }
}

#Preview {
    DetermineLightDarkModeExample()
}
