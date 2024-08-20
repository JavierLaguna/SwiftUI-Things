
import SwiftUI

struct DropdownViewExample: View {
    
    private let pickerVelues = ["YouTube", "Instagram", "X (Twitter)", "Snapchat", "TikTok"]
    
    @State private var config: DropdownConfig = .init(activeText: "YouTube")
    
    var body: some View {
        NavigationStack {
            List {
                SourceDropdownView(config: $config)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .navigationTitle("Dropdown")
        }
        .dropdownOverlay($config, values: pickerVelues)
    }
}

private struct SourceDropdownView: View {
    
    @Binding var config: DropdownConfig
    
    var body: some View {
        HStack {
            Text(config.activeText)
            
            Spacer(minLength: 0)
            
            Image(systemName: "chevron.down")
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(.background, in: .rect(cornerRadius: config.cornerRadius))
        .contentShape(.rect(cornerRadius: config.cornerRadius))
        .onTapGesture {
            config.show = true
            withAnimation(.snappy(duration: 0.35, extraBounce: 0)) {
                config.showContent = true
            }
        }
        .onGeometryChange(for: CGRect.self) {
            $0.frame(in: .global)
        } action: { newValue in
            config.anchor = newValue
        }

    }
}

private struct DropdownConfig {
    var activeText: String
    var show = false
    var showContent = false
    var anchor: CGRect = .zero
    var cornerRadius: CGFloat = 10
}

private extension View {
    
    @ViewBuilder
    func dropdownOverlay(_ config: Binding<DropdownConfig>, values: [String]) -> some View {
        self
            .overlay {
                if config.wrappedValue.show {
                    DropdownView(values: values, config: config)
                        .transition(.identity)
                }
            }
    }
    
    @ViewBuilder
    func reverseMask<Content: View>(_ alignment: Alignment, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .mask {
                Rectangle()
                    .overlay(alignment: alignment) {
                        content()
                            .blendMode(.destinationOut)
                    }
            }
    }
}

private struct DropdownView: View {
    
    var values: [String]
    @Binding var config: DropdownConfig
    
    @State private var activeItem: String?
    
    private var filteredValues: [String] {
        values.filter {
            $0 != config.activeText
        }
    }
    
    @ViewBuilder
    private func itemView(_ item: String) -> some View {
        HStack {
            Text(item)
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 15)
        .frame(height: config.anchor.height)
        .contentShape(.rect)
        .onTapGesture {
            closeDropdown(item)
        }
    }
    
    private func closeDropdown(_ item: String) {
        withAnimation(.easeInOut(duration: 0.35), completionCriteria: .logicallyComplete) {
            activeItem = item
            config.showContent = false
            
        } completion: {
            config.activeText = item
            config.show = false
        }

    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                itemView(config.activeText)
                    .id(config.activeText)
                
                ForEach(filteredValues, id: \.self) { item in
                    itemView(item)
                }
            }
            .scrollTargetLayout()
        }
        .safeAreaPadding(.bottom, 200 - config.anchor.height)
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        .scrollPosition(id: $activeItem, anchor: .top)
        .scrollIndicators(.hidden)
        .frame(width: config.anchor.width, height: 200)
        .background(.background)
        .mask(alignment: .top) {
            Rectangle()
                .frame(height: config.showContent ? 200 : config.anchor.height, alignment: .top)
        }
        .overlay(alignment: .topTrailing) {
            Image(systemName: "chevron.down")
                .rotationEffect(.init(degrees: config.showContent ? 180 : 0))
                .padding(.trailing, 15)
                .frame(height: config.anchor.height)
        }
        .clipShape(.rect(cornerRadius: config.cornerRadius))
        .offset(x: config.anchor.minX, y: config.anchor.minY)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background {
            if config.showContent {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .reverseMask(.topLeading) {
                        RoundedRectangle(cornerRadius: config.cornerRadius)
                            .frame(width: config.anchor.width, height: 200)
                            .offset(x: config.anchor.minX, y: config.anchor.minY)
                    }
                    .transition(.opacity)
                    .onTapGesture {
                        closeDropdown(activeItem ?? config.activeText)
                    }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DropdownViewExample()
}
