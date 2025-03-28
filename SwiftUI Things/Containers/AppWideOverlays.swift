import SwiftUI
import AVKit

struct AppWideOverlays: View {
    
    @State private var showVideoPlayer = false
    @State private var showTextConnected = false
    @State private var showSheet = false
    @State private var text = ""
    
    var body: some View {
        RootView {
            NavigationStack {
                List {
                    TextField("Message", text: $text)
                    
                    Button("Floating Video Player") {
                        showVideoPlayer.toggle()
                    }
                    .universalOverlay(show: $showVideoPlayer) {
                        FloatingVideoPlayerView(show: $showVideoPlayer)
                    }
                    
                    Button("Text connected") {
                        showTextConnected.toggle()
                    }
                    .universalOverlay(show: $showTextConnected) {
                        TextConectedView(text: $text, show: $showTextConnected)
                    }
                    
                    Button("Show Dummy Sheet") {
                        showSheet.toggle()
                    }
                }
                .navigationTitle("Universal Overlay")
            }
            .sheet(isPresented: $showSheet) {
                Text("Hello From Sheets!")
            }
        }
    }
}

extension View {
    
    @ViewBuilder
    func universalOverlay<Content: View>(
        animation: Animation = .snappy,
        show: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(UniversalOverlayModifier(animation: animation, show: show, viewContent: content))
    }
}

fileprivate struct UniversalOverlayModifier<ViewContent: View>: ViewModifier {
    
    var animation: Animation
    @Binding var show: Bool
    @ViewBuilder var viewContent: () -> ViewContent
    
    @Environment(UniversalOverlayProperties.self) private var properties
    @State private var viewId: String?
    
    private func addView() {
        if properties.window != nil, viewId == nil {
            viewId = UUID().uuidString
            guard let viewId else { return }
            
            withAnimation(animation) {
                properties.view.append(.init(id: viewId, view: AnyView(viewContent())))
            }
        }
    }
    
    private func removeView() {
        if let viewId {
            withAnimation(animation) {
                properties.view.removeAll {
                    $0.id == viewId
                }
            }
            
            self.viewId = nil
        }
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: show) { oldValue, newValue in
                if newValue {
                    addView()
                } else {
                    removeView()
                }
            }
    }
}

@Observable
final class UniversalOverlayProperties {
    var window: UIWindow?
    var view: [OverlayView] = []
    
    struct OverlayView: Identifiable {
        var id: String = UUID().uuidString
        var view: AnyView
    }
}

struct RootView<Content: View>: View {
    
    var content: Content
    var properties = UniversalOverlayProperties()
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .environment(properties)
            .onAppear {
                if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene), properties.window == nil {
                    let window = PassThroughWindow(windowScene: windowScene)
                    window.isHidden = false
                    window.isUserInteractionEnabled = true
                    
                    let rootViewController = UIHostingController(
                        rootView: UniversalOverlayViews()
                            .environment(properties)
                    )
                    rootViewController.view.backgroundColor = .clear
                    window.rootViewController = rootViewController
                    
                    properties.window = window
                }
            }
    }
}

fileprivate struct UniversalOverlayViews: View {
    
    @Environment(UniversalOverlayProperties.self) private var properties
    
    var body: some View {
        ZStack {
            ForEach(properties.view) {
                $0.view
            }
        }
    }
}

fileprivate class PassThroughWindow: UIWindow {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event),
              let rootView = rootViewController?.view
        else {
            return nil
        }
        
        if #available(iOS 18, *) {
            for subview in rootView.subviews.reversed() {
                let pointInSubview = subview.convert(point, from: rootView)
                if subview.hitTest(pointInSubview, with: event) == subview {
                    return hitView
                }
            }
            
            return nil
            
        } else {
            return hitView == rootView ? nil : hitView
        }
    }
}

private struct TextConectedView: View {
    @Binding var text: String
    @Binding var show: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.red)
            .overlay {
                Text("\(text)")
            }
            .frame(width: 250, height: 250)
            .onTapGesture {
                print("Tapped")
            }
    }
}

struct FloatingVideoPlayerView: View {
    @Binding var show: Bool
    @State private var player: AVPlayer?
    @State private var offset: CGSize = .zero
    @State private var lastStoredOffset: CGSize = .zero
    
    var videoURL: URL? {
        if let bundle = Bundle.main.path(forResource: "battery", ofType: "mp4") {
            return .init(filePath: bundle)
        }
        
        return nil
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            Group {
                if let videoURL {
                    VideoPlayer(player: player)
                        .background(.black)
                        .clipShape(.rect(cornerRadius: 25))
                    
                } else {
                    RoundedRectangle(cornerRadius: 25)
                }
            }
            .frame(height: 250)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let translation = value.translation + lastStoredOffset
                        offset = translation
                    }
                    .onEnded { value in
                        withAnimation(.bouncy) {
                            offset.width = 0
                            
                            if offset.height < 0 {
                                offset.height = 0
                            }
                            
                            if offset.height > (size.height - 250) {
                                offset.height = (size.height - 250)
                            }
                        }
                        
                        lastStoredOffset = offset
                    }
            )
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .padding(.horizontal, 15)
        .transition(.blurReplace)
        .onAppear {
            if let videoURL {
                player = AVPlayer(url: videoURL)
                player?.play()
            }
        }
    }
}

extension CGSize {
    
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

#Preview {
    AppWideOverlays()
}
