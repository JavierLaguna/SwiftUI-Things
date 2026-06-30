import SwiftUI

extension DefaultScrollAnchorExample: NativeModifiersThing {
    static let title = "Default Scroll Anchor"
    static func makeView() -> some View { Self() }
}

struct DefaultScrollAnchorExample: View {

    @State private var selectedAnchor: AnchorOption = .bottom

    var body: some View {
        VStack(spacing: 0) {
            Picker("Anchor", selection: $selectedAnchor) {
                ForEach(AnchorOption.allCases) { option in
                    Text(option.label).tag(option)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.vertical, 12)

            Text(".defaultScrollAnchor(.\(selectedAnchor.rawValue))")
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
                .padding(.horizontal)

            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(1...5, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 56)
                            .overlay {
                                Text("Item \(i)")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                            }
                    }
                }
                .padding()
            }
            .defaultScrollAnchor(selectedAnchor.unitPoint)
            .id(selectedAnchor.id)
        }
        .navigationTitle("Default Scroll Anchor")
    }
}

private enum AnchorOption: String, CaseIterable, Identifiable {
    case top
    case center
    case bottom
    case leading
    case trailing

    var id: String { rawValue }

    var label: String {
        switch self {
        case .top: "Top"
        case .center: "Center"
        case .bottom: "Bottom"
        case .leading: "Leading"
        case .trailing: "Trailing"
        }
    }

    var unitPoint: UnitPoint {
        switch self {
        case .top: .top
        case .center: .center
        case .bottom: .bottom
        case .leading: .leading
        case .trailing: .trailing
        }
    }
}

#Preview {
    NavigationStack {
        DefaultScrollAnchorExample()
    }
}
