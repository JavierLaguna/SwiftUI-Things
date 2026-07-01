import SwiftUI

public struct StorybookBadge: Identifiable {
    public let id = UUID()
    public let title: String
    public let icon: String?

    public init(title: String, icon: String? = nil) {
        self.title = title
        self.icon = icon
    }
}

//@available(iOS 26.0, *)
public struct Storybook<Preview: View, Properties: View>: View {

    private let title: String
    private let badges: [StorybookBadge]
    private let code: String
    private let codeReplacements: [String: String]
    private let preview: Preview
    private let properties: Properties
    private let pasteboard = UIPasteboard.general

    public init(
        title: String,
        badges: [StorybookBadge] = [],
        code: String,
        codeReplacements: [String: String] = [:],
        @ViewBuilder preview: () -> Preview,
        @ViewBuilder properties: () -> Properties
    ) {
        self.title = title
        self.badges = badges
        self.code = code
        self.codeReplacements = codeReplacements
        self.preview = preview()
        self.properties = properties()
    }

    public init(
        title: String,
        badges: [StorybookBadge] = [],
        code: String,
        codeReplacements: [String: String] = [:],
        @ViewBuilder preview: () -> Preview
    ) where Properties == EmptyView {
        self.title = title
        self.badges = badges
        self.code = code
        self.codeReplacements = codeReplacements
        self.preview = preview()
        self.properties = EmptyView()
    }

    public var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 28) {
                headerView
                
                SectionCard(icon: "play.fill", title: "Live Preview") {
                    preview
                        .frame(maxWidth: .infinity)
                }
                
                propertiesSection
                
                codeSection
            }
            .padding(16)
        }
    }

    // MARK: - Header

    @ViewBuilder
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !badges.isEmpty {
                HStack(spacing: 8) {
                    ForEach(badges.indices, id: \.self) { index in
                        badgeView(badges[index], isPrimary: index == 0)
                    }
                    Spacer()
                }
            }

            Text(title)
                .font(.largeTitle.weight(.bold))
        }
    }

    @ViewBuilder
    private func badgeView(_ badge: StorybookBadge, isPrimary: Bool) -> some View {
        if isPrimary {
            Label(badge.title, systemImage: badge.icon ?? "")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Capsule().fill(.blue.gradient))
        } else {
            Text(badge.title)
                .font(.caption.weight(.medium))
                .foregroundStyle(.secondary)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Capsule().fill(.gray.opacity(0.15)))
        }
    }

    // MARK: - Properties

    @ViewBuilder
    private var propertiesSection: some View {
        if Properties.self != EmptyView.self {
            SectionCard(icon: "slider.horizontal.3", title: "Properties") {
                properties
            }
        }
    }

    // MARK: - Code

    private var codeSection: some View {
        let displayCode = applyReplacements(code)
        return VStack(alignment: .leading, spacing: 14) {
            Label("Code", systemImage: "chevron.left.forwardslash.chevron.right")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Label("ContentView.swift", systemImage: "swift")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)

                    Spacer()

                    Button {
                        pasteboard.string = displayCode
                    } label: {
                        Label("Copy", systemImage: "clipboard")
                            .font(.caption.weight(.medium))
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.tint)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(.gray.opacity(0.08))

                Divider()

                ScrollView(.horizontal, showsIndicators: false) {
                    Text(displayCode)
                        .font(.system(.callout, design: .monospaced))
                        .lineSpacing(6)
                        .padding(16)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
            .background(.gray.opacity(0.06))
            .clipShape(.rect(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray.opacity(0.15), lineWidth: 1)
            }
        }
    }

    private func applyReplacements(_ text: String) -> String {
        var result = text
        for (key, value) in codeReplacements {
            result = result.replacingOccurrences(of: key, with: value)
        }
        return result
    }
}
