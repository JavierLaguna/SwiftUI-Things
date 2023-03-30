
import SwiftUI

struct LongPressGestureExample: View {
    
    @GestureState private var press = false
    @State private var show = false
    
    var body: some View {
        Image(systemName: "camera.fill")
            .foregroundColor(.white)
            .frame(width: 60, height: 60)
            .background(show ? Color.black : Color.blue)
            .mask(Circle())
            .scaleEffect(press ? 2 : 1)
            .animation(
                .spring(response: 0.4, dampingFraction: 0.6),
                value: press
            )
            .gesture(
                LongPressGesture(minimumDuration: 0.5)
                    .updating($press) { currentState, gestureState, transaction in
                        gestureState = currentState
                    }
                    .onEnded { value in
                        show.toggle()
                    }
            )
    }
}

struct LongPressGestureExample_Previews: PreviewProvider {
    
    static var previews: some View {
        LongPressGestureExample()
    }
}
