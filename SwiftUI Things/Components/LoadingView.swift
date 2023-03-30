
import SwiftUI

struct LoadingView: View {
    
    @State private var didAppear = false
    
    var body: some View {
        Circle()
            .trim(from: 0.2, to: 1)
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
            .frame(width: 44, height: 44)
            .rotationEffect(Angle(degrees: didAppear ? 360 : 0))
            .animation(
                Animation.linear(duration: 2).repeatForever(autoreverses: false),
                value: didAppear
            )
            .onAppear {
                didAppear = true
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoadingView()
    }
}
