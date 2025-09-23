// Credits: Kavsoft
// https://www.youtube.com/watch?v=RwPsJhrPP9g

import SwiftUI

struct CustomMenuiOS26: View {
    
    @State private var selectedOption: CustomMenuStyle = .glass
    @State private var dismissDisabled = false
    
    var body: some View {
        if #available(iOS 26.0, *) {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 32) {
                    
                    Text("Live Example")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Transaction History")
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            Text("12 Jun 2025 - 20 Sep 2025")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        CustomMenuView(style: selectedOption) {
                            Image(systemName: "calendar")
                                .font(.title3)
                                .frame(width: 40, height: 30)
                            
                        } content: {
                            DateFilterView(
                                interactiveDismissDisabled: dismissDisabled
                            )
                        }
                    }
                    
                    Text("Properties")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Picker("CustomMenuStyle", selection: $selectedOption) {
                            ForEach(CustomMenuStyle.allCases, id: \.self) { item in
                                Text("\(item.rawValue)").tag(item)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        Divider()
                        
                        Toggle("Interactive Dismiss Disabled", isOn: $dismissDisabled)
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .glassEffect(.regular, in: .rect(cornerRadius: 30))
                    
                    Text("Code")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Usage:")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            .underline()
                        
                        Text(
                            """
                            CustomMenuView(style: \(selectedOption.codeValue)) {
                                Image(systemName: "calendar")
                                    .font(.title3)
                                    .frame(width: 40, height: 30)
                                
                            } content: {
                                DateFilterView(
                                    interactiveDismissDisabled: \(String(describing: dismissDisabled))
                                )                                
                            }                            
                            """
                        )
                        .font(.system(.body, design: .monospaced))
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.gray.opacity(0.15))
                    }
                }
                .padding(16)
            }
            
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
