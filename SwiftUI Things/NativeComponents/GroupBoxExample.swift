import SwiftUI
import iOS26Macros

extension GroupBoxExample: NativeComponentThing {
    static let title = "GroupBox"
    static func makeView() -> some View { Self() }
}

struct GroupBoxExample: View {

    @State private var isExpanded = false
    @State private var selectedOption = 0

    var body: some View {
        let (preview, code) = #CodeSnippet(
            GroupBox {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Status")

                        Spacer()

                        Text("Active")
                            .foregroundStyle(.green)
                            .fontWeight(.semibold)
                    }

                    Divider()

                    HStack {
                        Text("Team Members:")

                        Spacer()

                        Text("5")
                            .fontWeight(.semibold)
                    }

                    if isExpanded {
                        Divider()

                        Picker("Priority", selection: $selectedOption) {
                            Text("Low").tag(0)
                            Text("Medium").tag(1)
                            Text("High").tag(2)
                        }
                        .pickerStyle(.segmented)

                        Divider()
                    }

                    Button {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    } label: {
                        Text(isExpanded ? "Show Less" : "Show More")
                            .font(.footnote)
                            .foregroundStyle(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.top, 8)

            } label: {
                Label("Project Overview", systemImage: "briefcase")
                    .font(.headline)
            }
            .padding()
            .clipShape(.rect(cornerRadius: 12))
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Component", icon: "square.3.layers.3d"),
            ],
            description: "A native GroupBox containing a project overview with collapsible priority picker and expandable content controlled by internal state.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    GroupBoxExample()
}
