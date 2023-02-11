
import SwiftUI

struct SlideTo: View {
    
    typealias OnComplete = () -> Void
    
    private let hapticFeedback = UINotificationFeedbackGenerator()
    private let buttonSize: CGFloat = 80
    private let animationDuration = 0.4
    
    private let title: String
    private let color: String
    private let moveToStartAfterComplete: Bool
    private let onComplete: OnComplete
    
    @State private var buttonOffset: CGFloat = 0
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 100
    
    init(title: String, color: String = "ColorRed", moveToStartAfterComplete: Bool = true, onComplete: @escaping OnComplete) {
        self.title = title
        self.color = color
        self.moveToStartAfterComplete = moveToStartAfterComplete
        self.onComplete = onComplete
    }
    
    private func moveToStart() {
        withAnimation(Animation.easeOut(duration: animationDuration)) {
            buttonOffset = 0
        }
    }
    
    private func moveToEnd() {
        withAnimation(Animation.easeOut(duration: animationDuration)) {
            buttonOffset = buttonWidth - buttonSize
        }
    }
    
    private func onFinishGesture() {
        guard buttonOffset > (buttonWidth * 0.70) else {
            moveToStart()
            hapticFeedback.notificationOccurred(.warning)
            return
        }
        
        moveToEnd()
        hapticFeedback.notificationOccurred(.success)
        onComplete()
        
        if moveToStartAfterComplete {
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                moveToStart()
            }
        }
    }
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.white.opacity(0.2))
            
            Capsule()
                .fill(Color.white.opacity(0.2))
                .padding(8)
            
            
            
            Text(title)
                .font(.system(.title3, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .offset(x: 20)
            
            
            
            HStack {
                Capsule()
                    .fill(Color(color))
                    .frame(width: buttonOffset + 70)
                
                Spacer()
            }
            
            
            
            HStack {
                ZStack {
                    Circle()
                        .fill(Color(color))
                    Circle()
                        .fill(.black.opacity(0.15))
                        .padding(8)
                    Image(systemName: "chevron.right.2")
                        .font(.system(size: 24, weight: .bold))
                }
                .foregroundColor(.white)
                .frame(width: buttonSize, height: buttonSize, alignment: .center)
                .offset(x: buttonOffset)
                .gesture(DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width > 0, buttonOffset <= buttonWidth - buttonSize {
                            buttonOffset = gesture.translation.width
                        }
                    }
                    .onEnded { _ in
                        onFinishGesture()
                    }
                )
                
                Spacer()
            }
        }
        .frame(width: buttonWidth, height: buttonSize, alignment: .center)
    }
}

struct SlideToSandbox: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            SlideTo(
                title: "Get Started",
                color: "ColorBlue"
            ) {
                print("Completed!")
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.black)
    }
}

struct SlideTo_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SlideTo(title: "Get Started") {
                print("Completed!")
            }
            .previewLayout(.sizeThatFits)
            
            SlideToSandbox()
                .previewDisplayName("Sanbox")
        }
    }
}
