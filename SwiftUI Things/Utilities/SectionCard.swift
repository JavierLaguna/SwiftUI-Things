import SwiftUI

@available(iOS 26.0, *)
struct SectionCard<Content: View>: View {
    let icon: String
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label(title, systemImage: icon)
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            content
        }
        .padding(20)
        .glassEffect(.regular, in: .rect(cornerRadius: 24))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    if #available(iOS 26.0, *) {
        SectionCard(icon: "star.fill", title: "Preview") {
            Text("Hello from SectionCard")
        }
    }
}
