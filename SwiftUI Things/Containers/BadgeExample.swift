import SwiftUI

extension BadgeExample: NativeModifiersThing {
    static let title = "Badge"
    static func makeView() -> some View { Self() }
}

struct BadgeExample: View {
    
    var body: some View {
        TabView {
            List {
                Text("Badge")
                    .badge(22)
                
                Text("Custom badge view")
                    .badge(
                        Text("25 A")
                            .foregroundStyle(.colorAppleDark)
                            .bold()
                    )
            }
            .tabItem {
                Label("Tab View", systemImage: "figure.table.tennis")
            }
            .badge(33)
        }
    }
}

#Preview {
    BadgeExample()
}
