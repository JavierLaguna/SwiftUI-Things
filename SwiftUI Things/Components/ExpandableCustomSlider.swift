import SwiftUI

struct ExpandableCustomSlider<Overlay: View>: View {
    @Binding var value: CGFloat
    var range: ClosedRange<CGFloat>
    var config: Config
    var overlay: Overlay
    
    @State private var lastStoredValue: CGFloat
    @GestureState private var isActive = false
    
    init(
        value: Binding<CGFloat>,
        in range: ClosedRange<CGFloat>,
        config: Config = .init(),
        @ViewBuilder overlay: @escaping () -> Overlay
    ) {
        self._value = value
        self.range = range
        self.config = config
        self.overlay = overlay()
        self.lastStoredValue = value.wrappedValue
    }
    
    struct Config {
        var inActiveTint: Color = .black.opacity(0.06)
        var activeTint: Color = .primary
        var cornerRadius: CGFloat = 15
        var extraHeight: CGFloat = 25
        var overlayActiveTint: Color = .white
        var overlayInActiveTint: Color = .black
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let width = (value / range.upperBound) * size.width
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(config.inActiveTint)
                
                Rectangle()
                    .fill(config.activeTint)
                    .mask(alignment: .leading) {
                        Rectangle()
                            .frame(width: width)
                    }
                
                ZStack(alignment: .leading) {
                    overlay
                        .foregroundStyle(config.overlayInActiveTint)
                    
                    overlay
                        .foregroundStyle(config.overlayActiveTint)
                        .mask(alignment: .leading) {
                            Rectangle()
                                .frame(width: width)
                        }
                }
                .compositingGroup()
                .animation(.easeInOut(duration: 0.3).delay(isActive ? 0.12 : 0).speed(isActive ? 1 : 2)) {
                    $0.opacity(isActive ? 1 : 0)
                }
            }
            .contentShape(.rect)
            .highPriorityGesture(
                DragGesture(minimumDistance: 0)
                    .updating($isActive) { _, out, _ in
                        out = true
                    }
                    .onChanged { value in
                        let progress = ((value.translation.width / size.width) * range.upperBound) + lastStoredValue
                        self.value = max(min(progress, range.upperBound), range.lowerBound)
                    }
                    .onEnded { _ in
                        lastStoredValue = value
                    }
            )
        }
        .frame(height: 20 + config.extraHeight)
        .mask {
            RoundedRectangle(cornerRadius: config.cornerRadius)
                .frame(height: 20 + (isActive ? config.extraHeight : 0))
        }
        .animation(.snappy, value: isActive)
    }
}

struct ExpandableCustomSliderExample: View {
    
    @State private var volume: CGFloat = 30
    
    var body: some View {
        NavigationStack {
            VStack {
                ExpandableCustomSlider(value: $volume, in: 0...100) {
                    HStack {
                        Image(
                            systemName: "speaker.wave.3.fill",
                            variableValue: volume / 100
                        )
                        
                        Spacer(minLength: 0)
                        
                        Text(String(format: "%1.f", volume) + "%")
                            .font(.callout)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(15)
            .navigationTitle("Expandable Slider")
        }
    }
}

#Preview {
    ExpandableCustomSliderExample()
}
