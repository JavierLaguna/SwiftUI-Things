import SwiftUI

struct DragNDropWithScrollExample: View {
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            
            Image(.sonoma)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 40, opaque: true)
                .overlay {
                    Rectangle()
                        .fill(.black.opacity(0.15))
                }
                .ignoresSafeArea()
            
            Home(safeArea: safeArea)
        }
    }
}

private struct Home: View {
    
    let safeArea: EdgeInsets
    
    @State private var controls: [Control] = Control.items
    @State private var selectedControl: Control?
    @State private var selectedControlFrame: CGRect = .zero
    @State private var selectedControlScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var scrollPosition: ScrollPosition = .init()
    @State private var currentScrollOffset: CGFloat = 0
    @State private var lastActiveScrollOffset: CGFloat = 0
    @State private var maximunScrollSize: CGFloat = 0
    @State private var scrollTimer: Timer?
    @State private var topRegion: CGRect = .zero
    @State private var bottomRegion: CGRect = .zero
    @State private var hapticsTrigger = false
    @State private var isGrid = false
    
    private func customCombinedGesture(_ control: Control) -> some Gesture {
        LongPressGesture(minimumDuration: 0.25)
            .sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .global))
            .onChanged { value in
                switch value {
                case let .second(status, value):
                    if status {
                        if selectedControl == nil {
                            selectedControl = control
                            selectedControlFrame = control.frame
                            lastActiveScrollOffset = currentScrollOffset
                            hapticsTrigger.toggle()
                            
                            withAnimation(.smooth(duration: 0.25, extraBounce: 0)) {
                                selectedControlScale = 1.05
                            }
                        }
                        
                        if let value {
                            offset = value.translation
                            let location = value.location
                            checkAndScroll(location)
                        }
                    }
                default: ()
                }
            }
            .onEnded { _ in
                scrollTimer?.invalidate()
                
                withAnimation(.snappy(duration: 0.25, extraBounce: 0), completionCriteria: .logicallyComplete) {
                    
                    selectedControl?.frame = selectedControlFrame
                    selectedControlScale = 1.0
                    offset = .zero
                    
                } completion: {
                    selectedControl = nil
                    scrollTimer = nil
                    lastActiveScrollOffset = 0
                }
            }
    }
    
    private func checkAndSwapItems(_ location: CGPoint) {
        if let currentIndex = controls.firstIndex(where: { $0.id == selectedControl?.id }),
           let fallingIndex = controls.firstIndex(where: { $0.frame.contains(location) }) {
            
            withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                (controls[currentIndex], controls[fallingIndex]) = (controls[fallingIndex], controls[currentIndex])
            }
        }
    }
    
    private func checkAndScroll(_ location: CGPoint) {
        let topStatus = topRegion.contains(location)
        let bottomStatus = bottomRegion.contains(location)
        
        if topStatus || bottomStatus {
            guard scrollTimer == nil else { return }
                    
            scrollTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                if topStatus {
                    lastActiveScrollOffset = max(lastActiveScrollOffset - 10, 0)
                } else {
                    lastActiveScrollOffset = min(lastActiveScrollOffset + 10, maximunScrollSize)
                }
                
                scrollPosition.scrollTo(y: lastActiveScrollOffset)
                
                checkAndSwapItems(location)
            })
            
        } else {
            scrollTimer?.invalidate()
            scrollTimer = nil
            
            checkAndSwapItems(location)
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            HStack {
                Spacer()
                
                Button {
                    withAnimation(.bouncy(duration: 0.25)) {
                        isGrid.toggle()
                    }
                    
                } label: {
                    Image(systemName: isGrid ? "square.split.1x2" : "square.split.2x2")
                        .font(.title)
                        .foregroundStyle(.white)
                }

            }
            .padding(.horizontal, 24)
            
//            LazyVStack(spacing: 20) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: isGrid ? 4 : 1)) {
                ForEach($controls) { $control in
                    ControlView(
                        control: control,
                        smallSize: isGrid
                    )
                    .opacity(selectedControl?.id == control.id ? 0 : 1)
                    .onGeometryChange(for: CGRect.self) {
                        $0.frame(in: .global)
                    } action: { newValue in
                        if selectedControl?.id == control.id {
                            selectedControlFrame = newValue
                        }
                        
                        control.frame = newValue
                    }
                    .gesture(customCombinedGesture(control))
                }
            }
            .padding(25)
        }
        .scrollPosition($scrollPosition)
        .onScrollGeometryChange(for: CGFloat.self, of: {
            $0.contentOffset.y + $0.contentInsets.top
            
        }, action: { _, newValue in
            currentScrollOffset = newValue
        })
        .onScrollGeometryChange(for: CGFloat.self, of: {
            $0.contentSize.height - $0.containerSize.height
            
        }, action: { _, newValue in
            maximunScrollSize = newValue
        })
        .overlay(alignment: .topLeading) {
            if let selectedControl {
                ControlView(
                    control: selectedControl,
                    smallSize: isGrid
                )
                .frame(
                    width: selectedControl.frame.width,
                    height: selectedControl.frame.height
                )
                .scaleEffect(selectedControlScale)
                .offset(
                    x: selectedControl.frame.minX,
                    y: selectedControl.frame.minY
                )
                .offset(offset)
                .ignoresSafeArea()
                .transition(.identity)
            }
        }
        .overlay(alignment: .top) {
            Rectangle()
                .fill(.clear)
                .frame(height: 20 + safeArea.top)
                .onGeometryChange(for: CGRect.self, of: {
                    $0.frame(in: .global)
                }, action: { newValue in
                    topRegion = newValue
                })
                .offset(y: -safeArea.top)
                .allowsHitTesting(false)
        }
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(.clear)
                .frame(height: 20 + safeArea.bottom)
                .onGeometryChange(for: CGRect.self, of: {
                    $0.frame(in: .global)
                }, action: { newValue in
                    bottomRegion = newValue
                })
                .offset(y: safeArea.bottom)
                .allowsHitTesting(false)
        }
        .allowsHitTesting(selectedControl == nil)
        .sensoryFeedback(.impact, trigger: hapticsTrigger)
    }
}

private struct ControlView: View {
    
    let control: Control
    let smallSize: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: control.symbol)
                .font(.title3)
            
            if !smallSize {
                Text(control.title)
                
                Spacer(minLength: 0)
            }
        }
        .padding(.horizontal, 15)
        .foregroundStyle(.white)
        .frame(maxWidth: smallSize ? 60 : .infinity)
        .frame(height: 60)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
        }
    }
}

private struct Control: Identifiable, Hashable {
    var id: UUID = .init()
    var symbol: String
    var title: String
    var frame: CGRect = .zero
    
    static let items: [Control] = [
        Control(symbol: "airplane", title: "Airplane Mode"),
        Control(symbol: "wifi", title: "Wifi"),
        Control(symbol: "cellularbars", title: "Cellular Data"),
        Control(symbol: "personalhotspot", title: "Personal Hotspot"),
        Control(symbol: "flashlight.off.fill", title: "Flashlight"),
        Control(symbol: "square.on.square", title: "Screen Mirror"),
        Control(symbol: "lock.rotation", title: "Device Orientation"),
        Control(symbol: "moonphase.last.quarter", title: "Dark Mode"),
        Control(symbol: "battery.50percent", title: "Low Power Mode"),
        Control(symbol: "record.circle", title: "Screen Record"),
        Control(symbol: "qrcode.viewfinder", title: "QR Scanner"),
        Control(symbol: "shazam.logo", title: "Shazam"),
        Control(symbol: "timer", title: "Timer"),
        Control(symbol: "stopwatch", title: "Stopwatch"),
        Control(symbol: "camera.fill", title: "Camera")
    ]
}

#Preview {
    DragNDropWithScrollExample()
}
