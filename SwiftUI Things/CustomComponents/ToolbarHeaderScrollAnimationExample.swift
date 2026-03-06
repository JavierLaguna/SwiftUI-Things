// Credits: Kavsoft
// https://www.youtube.com/watch?v=_h5S15Umk0Y

import SwiftUI

extension ToolbarHeaderScrollAnimationExample: CustomComponentThing {
    static let title = "ToolbarHeaderScrollAnimation"
    static func makeView() -> some View { Self() }
}

struct ToolbarHeaderScrollAnimationExample: View {
    
    @State private var isPrimaryActionVisible = false
    @State private var useLeadingFixedTitles = true
    @State private var title: String?
    @State private var subtitle: String?
    @State private var activeSubtitleIndex: Int?
    @State private var safeArea: EdgeInsets = .init()
    
    @ViewBuilder
    private func HeaderView() -> some View {
        if #available(iOS 26.0, *) {
            VStack(alignment: .leading, spacing: 16) {
                Image(systemName: "swift")
                    .font(.system(size: 40))
                    .foregroundStyle(.orange)
                    .padding(16)
                    .background(.orange.tertiary, in: .circle)
                    .padding(.bottom, 6)
                
                Text("Swift/SwiftUI")
                    .font(.title.bold())
                    .onGeometryChange(for: Bool.self) {
                        let height = $0.size.height
                        let offset = $0.frame(in: .global).minY
                        return -offset > height
                        
                    } action: { newValue in
                        title = newValue ? "Swift/SwiftUI" : nil
                    }

                
                Text("**125** Eventes   **5.6KK** Subscribers")
                    .font(.callout)
                
                Text("Lorem ipsum dolor sit amet consectetur adipiscing, elit cubilia maecenas inceptos rutrum hac, sed faucibus interdum commodo curabitur. Gravida felis leo ut habitant eget in nam turpis vitae, quam taciti nullam aliquet rhoncus quisque dictumst fusce mattis, vel dui maecenas enim morbi sociosqu himenaeos erat. Fusce penatibus dictum pellentesque odio sagittis lobortis fermentum hendrerit mattis placerat, vel sociis facilisi tortor quisque tempus nisi mus primis, iaculis nisl ac egestas leo pulvinar ante quam vulputate.")
                    .font(.callout)
                    .lineLimit(5)
                
                Button("Subscribe") {
                    
                }
                .buttonStyle(.glassProminent)
                .buttonSizing(.flexible)
                .frame(maxWidth: 140)
                .tint(.orange)
                .onGeometryChange(for: Bool.self) {
                    let height = $0.size.height
                    let offset = $0.frame(in: .global).minY
                    return -offset > height
                    
                } action: { newValue in
                    isPrimaryActionVisible = newValue
                }
            }
            .padding(.bottom, 16)
            .overlay(alignment: .bottom) {
                Divider()
                    .padding(.horizontal, -16)
            }
            
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func CenterDummyContent() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Popular Events")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Image("chevron.right")
                    .foregroundStyle(.gray)
            }
            
            RoundedRectangle(cornerRadius: 32)
                .foregroundStyle(.gray.tertiary)
                .frame(height: 220)
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
        .overlay(alignment: .bottom) {
            Divider()
                .padding(.horizontal, -16)
        }
    }
    
    @ViewBuilder
    private func EventsOnDay(_ index: Int) -> some View {
        let title = sampleEvents[index]
        
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .animation(.smooth(duration: 0.3, extraBounce: 0), body: { content in
                    content
                        .scaleEffect(activeSubtitleIndex == index ? 0.01 : 1, anchor: .top)
                })
                .onGeometryChange(for: Bool.self) {
                    let offset = $0.frame(in: .scrollView).minY
                    return -offset > 30
                    
                } action: { newValue in
                    let previousIndex = index - 1
                    activeSubtitleIndex = newValue ? index : (previousIndex < 0 ? nil : previousIndex)
                }
            
            ForEach(1...5, id: \.self) { _ in
                HStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 100)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 250, height: 25)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(height: 25)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 150, height: 25)
                    }
                }
                .foregroundStyle(.gray.tertiary)
            }
        }
        
    }
    
    private var sampleEvents: [String] {
        ["Tomorrow / Thursday", "Feb 12 / Friday", "Feb 13 / Saturday"]
    }
    
    var body: some View {
        if #available(iOS 26.0, *) {
            NavigationStack {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        HeaderView()
                        
                        CenterDummyContent()
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Nearby Events")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            ForEach(sampleEvents.indices, id: \.self) {
                                EventsOnDay($0)
                            }
                        }
                        .padding(.bottom, 50)
                    }
                    .padding(16)
                }
                .customToolBar(
                    isPrimaryActionVisible: isPrimaryActionVisible,
                    useLeadingFixedTitles: useLeadingFixedTitles,
                    title: title,
                    subtitle: subtitle) {
                        Button("Back", systemImage: "chevron.left") {
                            isPrimaryActionVisible.toggle()
                        }
                        
                    } trailing: {
                        HStack(spacing: 16) {
                            Button("Search", systemImage: "magnifyingglass") {
                                
                            }
                            
                            Button("Options", systemImage: "ellipsis") {
                                useLeadingFixedTitles.toggle()
                            }
                        }
                        .padding(.horizontal, 4)
                        
                    } primaryAction: {
                        Button("Add", systemImage: "plus") {
                            
                        }
                        .buttonStyle(.glassProminent)
                        .tint(.orange)
                    }
                
            }
            .onGeometryChange(for: EdgeInsets.self) {
                $0.safeAreaInsets
                
            } action: { newValue in
                print(newValue)
                safeArea = newValue
            }
            .onChange(of: activeSubtitleIndex) { oldValue, newValue in
                if let newValue {
                    subtitle = sampleEvents[newValue]
                } else {
                    subtitle = nil
                }
            }

            
        } else {
            Text("iOS 26 device required")
        }
    }
}

private extension View {
    
    @ViewBuilder
    func customToolBar<Leading: View, Trailing: View, PrimaryAction: View>(
        isPrimaryActionVisible: Bool,
        useLeadingFixedTitles: Bool,
        title: String?,
        subtitle: String?,
        @ViewBuilder leading: @escaping () -> Leading,
        @ViewBuilder trailing: @escaping () -> Trailing,
        @ViewBuilder primaryAction: @escaping () -> PrimaryAction
    ) -> some View {
        self
            .modifier(
                CustomToolbarModifier(
                    isPrimaryActionVisible: isPrimaryActionVisible,
                    useLeadingFixedTitles: useLeadingFixedTitles,
                    title: title,
                    subtitle: subtitle,
                    leading: leading,
                    trailing: trailing,
                    primaryAction: primaryAction
                )
            )
    }
}

// Helper View Modifier
private struct CustomToolbarModifier<Leading: View, Trailing: View, PrimaryAction: View>: ViewModifier {
    
    var isPrimaryActionVisible: Bool
    var useLeadingFixedTitles: Bool
    var title: String?
    var subtitle: String?
    @ViewBuilder var leading: Leading
    @ViewBuilder var trailing: Trailing
    @ViewBuilder var primaryAction: PrimaryAction
    
    private var emptyLargeString: String {
        String(repeating: " ", count: 50) // Nice for iPhone, maybe increase on iPad
    }
    
    @ViewBuilder private var TitlesView: some View {
        VStack(alignment: .leading, spacing: 2) {
            if let title {
                Text(title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .transition(.offset(y: 10).combined(with: AnyTransition(.blurReplace)))
            }
            
            if let subtitle {
                Text(subtitle)
                    .font(.caption2)
                    .foregroundStyle(.gray)
                    .contentTransition(.numericText())
                    .transition(.blurReplace)
            }
        }
    }
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    leading
                }
                
                ToolbarItem(placement: .title) {
                    if useLeadingFixedTitles {
                        Text(emptyLargeString)
                            .overlay(alignment: .leading) {
                                TitlesView
                                    .animation(.easeInOut(duration: 0.25), value: title)
                                    .animation(.easeInOut(duration: 0.25), value: subtitle)
                            }
                            .lineLimit(1)
                        
                    } else {
                        TitlesView
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    trailing
                }
                
                if isPrimaryActionVisible {
                    ToolbarItem(placement: .topBarTrailing) {
                        primaryAction
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
        // Primary action Animation
            .animation(.bouncy(duration: 0.3, extraBounce: 0), value: isPrimaryActionVisible)
    }
}

#Preview {
    ToolbarHeaderScrollAnimationExample()
}
