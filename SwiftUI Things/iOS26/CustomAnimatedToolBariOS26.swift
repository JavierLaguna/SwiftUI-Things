// Credits: Kavsoft
// https://www.youtube.com/watch?v=lkgAG568O20

import SwiftUI

struct CustomAnimatedToolBariOS26: View {
    
    @State private var path: NavigationPath = .init()
    @State private var searchText = ""
    @FocusState private var isKeyboardActive: Bool
    
    var body: some View {
        if #available(iOS 26.0, *) {
            NavigationStack(path: $path) {
                List {
                    ForEach(1...5, id: \.self) { index in
                        NavigationLink(value: "iCloud+ Subscription") {
                            Text("iCloud+ Subscription \(index)")
                        }
                    }
                }
                .navigationTitle("Inbox")
                .navigationSubtitle("Last Updated - Just Now")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Options", systemImage: "ellipsis") {
                            
                        }
                    }
                }
                .safeAreaPadding(.bottom, 50)
                .navigationDestination(for: String.self) { value in
                    Text("Full-Email View")
                        .navigationTitle(value)
                }
                
            }
            .safeAreaBar(edge: .bottom, spacing: 0) {
                Text(".") // iOS26.0 Workaround, CustomBottomBar should be here and not on overlay
                    .blendMode(.destinationOut)
                    .frame(height: 50)
            }
            .overlay(alignment: .bottom) {
                CustomBottomBar(
                    path: $path,
                    searchText: $searchText,
                    isKeyboardActive: $isKeyboardActive
                ) { isExpanded in
                    Group {
                        ZStack {
                            Image(systemName: "line.3.horizontal.decrease")
                                .blurFade(!isExpanded)
                            
                            Image(systemName: "trash")
                                .blurFade(isExpanded)
                        }
                        
                        Group {
                            Image(systemName: "folder")
                            
                            Image(systemName: "arrowshape.turn.up.forward.fill")
                        }
                        .blurFade(isExpanded)
                    }
                    .font(.title2)
                    
                } mainAction: {
                    Image(systemName: isKeyboardActive ? "xmark" : "square.and.pencil")
                        .font(.title2)
                        .contentTransition(.symbolEffect)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(.circle)
                        .onTapGesture {
                            if isKeyboardActive {
                                isKeyboardActive = false
                            } else {
                                print("Write")
                            }
                        }
                }
            }
            
        } else {
            Text("iOS 26 device required")
        }
    }
}

@available(iOS 26.0, *)
private struct CustomBottomBar<LeadingContent: View, MainAction: View>: View {
    
    @Binding var path: NavigationPath
    @Binding var searchText: String
    var isKeyboardActive: FocusState<Bool>.Binding
    @ViewBuilder var leadingContent: (_ isExpanded: Bool) -> LeadingContent
    @ViewBuilder var mainAction: MainAction
    @State private var bounce: CGFloat = 0
    
    private var isExpanded: Bool {
        !path.isEmpty
    }
    
    var body: some View {
        GlassEffectContainer(spacing: 10) {
            HStack(spacing: 10) {
                if !isKeyboardActive.wrappedValue {
                    Circle()
                        .foregroundStyle(.clear)
                        .frame(width: 50, height: 50)
                        .overlay(alignment: .leading) {
                            let layout = isExpanded ? AnyLayout(HStackLayout(spacing: 10)) : AnyLayout(ZStackLayout())
                            
                            layout {
                                ForEach(subviews: leadingContent(isExpanded)) { subview in
                                    subview
                                        .frame(width: 50, height: 50)
                                }
                            }
                            .modifier(ScaleModifier(bounce: bounce))
                        }
                        .zIndex(1000)
                        .transition(.blurReplace)
                        .blurFade(!isKeyboardActive.wrappedValue)
                }
                
                GeometryReader {
                    let size = $0.size
                    let scale = 50 / size.width // 50 is the minimun width
                    
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        
                        TextField("Search", text: $searchText)
                            .submitLabel(.search)
                            .focused(isKeyboardActive)
                        
                        Image(systemName: "mic.fill")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 16)
                    .frame(width: size.width, height: size.height)
                    .geometryGroup()
                    .blurFade(!isExpanded)
                    .scaleEffect(isExpanded ? scale : 1, anchor: .topLeading)
                    .glassEffect(.regular.interactive(), in: .capsule)
                    .blurFade(!isExpanded)
                    .scaleEffect(isExpanded ? scale : 1, anchor: .leading)
                    .offset(x: isExpanded ? -50 : 0)
                }
                .frame(height: 50)
//                .padding(.leading, isKeyboardActive.wrappedValue ? -60 : 0)
                .disabled(isExpanded)
                
                mainAction
                    .frame(width: 50, height: 50)
                    .glassEffect(.regular.interactive(), in: .circle)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, isKeyboardActive.wrappedValue ? 15 : 0)
        .animation(.smooth(duration: 0.3, extraBounce: 0), value: isKeyboardActive.wrappedValue)
        .animation(.bouncy, value: isExpanded)
        .onChange(of: isExpanded) { oldValue, newValue in
            withAnimation(.bouncy) {
                bounce += 1
            }
        }
    }
}

private extension View {
    // Blur Fade In/Out
    @ViewBuilder
    func blurFade(_ status: Bool) -> some View {
        self
            .blur(radius: status ? 0 : 5)
            .opacity(status ? 1 : 0)
    }
}

@available(iOS 26.0, *)
private struct ScaleModifier: ViewModifier, Animatable {
    var bounce: CGFloat
    var animatableData: CGFloat {
        get { bounce }
        set { bounce = newValue }
    }
    
    var loopProgress: CGFloat {
        let moddedBounce = bounce.truncatingRemainder(dividingBy: 1)
        let value = moddedBounce > 0.5 ? 1 - moddedBounce : moddedBounce
        return value * 2
    }
    
    func body(content: Content) -> some View {
        content
            .compositingGroup()
            .blur(radius: loopProgress * 5)
            .offset(x: loopProgress * 15, y: loopProgress * 8)
            .glassEffect(.regular.interactive(), in: .capsule)
            .scaleEffect(1 + (loopProgress * 0.38), anchor: .center)
    }
}

#Preview {
    CustomAnimatedToolBariOS26()
}
