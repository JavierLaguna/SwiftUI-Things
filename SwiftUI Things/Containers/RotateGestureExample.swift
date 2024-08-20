import SwiftUI

struct RotateGestureExample: View {
    
    @State private var angle: Angle = .zero
    
    var body: some View {
        Image(systemName: "steeringwheel")
            .font(.system(size: 300))
            .shadow(radius: 10)
            .rotationEffect(angle)
            .gesture(
                RotateGesture()
                    .onChanged {
                        angle = $0.rotation
                    }
            )
    }
}

#Preview {
    RotateGestureExample()
}
