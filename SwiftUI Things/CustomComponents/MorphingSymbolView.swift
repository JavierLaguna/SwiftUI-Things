
import SwiftUI

struct MorphingSymbolView: View {
    
    struct Config {
        let font: Font
        let frame: CGSize
        let radius: CGFloat
        let foregroundColor: Color
        var keyFrameDuration: CGFloat = 0.4
        var symbolAnimation: Animation = .smooth(duration: 0.5, extraBounce: 0)
    }
    
    let symbol: String
    let config: Config
    
    @State private var trigger = false
    @State private var displayingSymbol = ""
    @State private var nextSymbol = ""
    
    @ViewBuilder
    private func imageView() -> some View {
        KeyframeAnimator(initialValue: CGFloat.zero, trigger: trigger) { radius in
            Image(systemName: displayingSymbol == "" ? symbol : displayingSymbol)
                .font(config.font)
                .blur(radius: radius)
                .frame(width: config.frame.width, height: config.frame.height)
                .onChange(of: radius) { oldValue, newValue in
                    if newValue.rounded() == config.radius {
                        withAnimation(config.symbolAnimation) {
                            displayingSymbol = nextSymbol
                        }
                    }
                }
            
        } keyframes: { _ in
            CubicKeyframe(config.radius, duration: config.keyFrameDuration)
            CubicKeyframe(0, duration: config.keyFrameDuration)
        }
    }
    
    var body: some View {
        Canvas { ctx, size in
            ctx.addFilter(.alphaThreshold(min: 0.4, color: config.foregroundColor))
            
            if let renderedImage = ctx.resolveSymbol(id: 0) {
                ctx.draw(renderedImage, at: .init(x: size.width / 2, y: size.height / 2))
            }
            
        } symbols: {
            imageView()
                .tag(0)
        }
        .frame(width: config.frame.width, height: config.frame.height)
        .onChange(of: symbol) { oldValue, newValue in
            trigger.toggle()
            nextSymbol = newValue
        }
        .task {
            guard displayingSymbol == "" else { return }
            
            displayingSymbol = symbol
        }
    }
}

#Preview {
    MorphingSymbolView(
        symbol: "gearshape.fill",
        config: .init(
            font: .system(size: 100, weight: .bold),
            frame: .init(width: 250, height: 200),
            radius: 15,
            foregroundColor: .black
        )
    )
}
