// Credits: Kavsoft
// https://www.youtube.com/watch?v=RwPsJhrPP9g

import SwiftUI
import iOS26Macros

extension CustomMenuiOS26: IOS26Thing {
    static let title = "Custom Menu iOS26"
    static func makeView() -> some View { Self() }
}

struct CustomMenuiOS26: View {

    @State private var selectedOption: CustomMenuStyle = .glass
    @State private var dismissDisabled = false

    var body: some View {
        if #available(iOS 26.0, *) {
            let (preview, code) = #CodeSnippet(
                CustomMenuView(style: selectedOption) {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .frame(width: 40, height: 30)
                } content: {
                    DateFilterView(
                        interactiveDismissDisabled: dismissDisabled
                    )
                }
            )

            Storybook(
                title: Self.title,
                badges: [
                    .init(title: "iOS 26+", icon: "iphone.gen4"),
                    .init(title: "UI Component"),
                ],
                code: code,
                codeReplacements: [
                    "selectedOption": selectedOption.codeValue,
                    "dismissDisabled": "\(dismissDisabled)",
                ],
                preview: {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Transaction History")
                                .font(.title3.weight(.medium))

                            Text("12 Jun 2025 - 20 Sep 2025")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        preview
                    }
                },
                properties: {
                    Picker("Menu Style", selection: $selectedOption) {
                        ForEach(CustomMenuStyle.allCases, id: \.self) { item in
                            Text(item.rawValue).tag(item)
                        }
                    }
                    .pickerStyle(.segmented)

                    Divider()

                    Toggle("Interactive Dismiss Disabled", isOn: $dismissDisabled)
                }
            )
        } else {
            Text("iOS 26 device required")
        }
    }
}

@available(iOS 26.0, *)
private struct CustomMenuView<Label: View, Content: View>: View {

    var style: CustomMenuStyle = .glass
    var isHapticsEnabled = true
    @ViewBuilder var label: Label
    @ViewBuilder var content: Content
    @State private var haptics = false
    @State private var isExpanded = false
    @Namespace private var namespace

    var body: some View {
        Button {
            if isHapticsEnabled {
                haptics.toggle()
            }

            isExpanded.toggle()

        } label: {
            label
                .matchedTransitionSource(id: "MENUCONTENT", in: namespace)
        }
        .applyStyle(style)
        .popover(isPresented: $isExpanded){
            PopOverHelper {
                content
            }
            .navigationTransition(.zoom(sourceID: "MENUCONTENT", in: namespace))
        }
        .sensoryFeedback(.selection, trigger: haptics)
    }
}

private enum CustomMenuStyle: String, CaseIterable {
    case glass = "Glass"
    case glassProminent = "Glass Prominent"

    var codeValue: String {
        switch self {
        case .glass: ".glass"
        case .glassProminent: ".glassProminent"
        }
    }
}

@available(iOS 26.0, *)
private extension View {

    @ViewBuilder
    func applyStyle(_ style: CustomMenuStyle) -> some View {
        switch style {
        case .glass:
            self.buttonStyle(.glass)
        case .glassProminent:
            self.buttonStyle(.glassProminent)
        }
    }
}

private struct PopOverHelper<Content: View>: View {
    @ViewBuilder var content: Content
    @State private var isVisible: Bool = false

    var body: some View {
        content
            .opacity(isVisible ? 1 : 0)
            .task {
                try? await Task.sleep(for: .seconds(0.1))
                withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                    isVisible = true
                }
            }
            .presentationCompactAdaptation(.popover)
    }
}

@available(iOS 26.0, *)
private struct DateFilterView: View {

    @Environment(\.dismiss) var dismiss

    private let interactiveDismissDisabled: Bool

    init(interactiveDismissDisabled: Bool = false) {
        self.interactiveDismissDisabled = interactiveDismissDisabled
    }

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("Filter Date Range")
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 10)

            DatePicker("Start Date", selection: .constant(.now), displayedComponents: [.date])
                .datePickerStyle(.compact)
                .font(.caption)

            DatePicker("End Date", selection: .constant(.now), displayedComponents: [.date])
                .datePickerStyle(.compact)
                .font(.caption)

            VStack(spacing: 10) {
                Button {
                    dismiss()

                } label: {
                    Text("Apply")
                        .font(.callout)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 2)
                }
                .tint(.blue)
                .buttonStyle(.glassProminent)

                Text("Maximun Range is 1 Year!")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            .padding(.top, 16)
        }
        .padding(16)
        .frame(width: 250, height: 250)
        .interactiveDismissDisabled(interactiveDismissDisabled)
    }
}

#Preview {
    CustomMenuiOS26()
}
