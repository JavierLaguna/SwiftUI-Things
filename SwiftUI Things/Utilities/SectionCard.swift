import SwiftUI

struct SectionCard<Content: View>: View {
    let icon: String
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Label(title, systemImage: icon)
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .padding(.bottom, 12)

            Divider()
                .padding(.bottom, 16)

            content
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 20)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SectionCard(icon: "star.fill", title: "Preview") {
        Text("Hello from SectionCard")
    }
}
