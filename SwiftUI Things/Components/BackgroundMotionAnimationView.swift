
import SwiftUI

struct BackgroundMotionAnimationView: View {
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    @State private var randomCircle = Int.random(in: 12...16)
    @State private var isAnimating: Bool = false
    
    private func randomCoordinate(max: CGFloat) -> CGFloat {
        return CGFloat.random(in: 0...max)
    }
    
    private func randomSize() -> CGFloat {
        return CGFloat(Int.random(in: 10...300))
    }
    
    private func randomScale() -> CGFloat {
        return CGFloat(Double.random(in: 0.1...2.0))
    }
    
    private func randomSpeed() -> Double {
        return Double.random(in: 0.025...1.0)
    }
    
    private func randomDelay() -> Double {
        return Double.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            ForEach(0...randomCircle, id: \.self) { item in
                let size = randomSize()
                
                Circle()
                    .foregroundColor(.gray)
                    .opacity(0.15)
                    .frame(width: size, height: size, alignment: .center)
                    .scaleEffect(isAnimating ? randomScale() : 1)
                    .position(
                        x: randomCoordinate(max: screenWidth),
                        y: randomCoordinate(max: screenHeight)
                    )
                    .animation(
                        Animation.interpolatingSpring(stiffness: 0.5, damping: 0.5)
                            .repeatForever()
                            .speed(randomSpeed())
                            .delay(randomDelay())
                    )
                    .onAppear(perform: {
                        isAnimating = true
                    })
            }
        }
        .drawingGroup()
        .ignoresSafeArea(.all)
    }
}

struct BackgroundMotionAnimationView_Previews: PreviewProvider {
    
    static var previews: some View {
        BackgroundMotionAnimationView()
    }
}
