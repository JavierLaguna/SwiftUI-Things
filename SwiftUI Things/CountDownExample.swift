import SwiftUI

extension CountDownExample: NativeComponentThing {
    static let title = "Count Down"
    static func makeView() -> some View { Self() }
}

struct CountDownExample: View {
    
    var body: some View {
        VStack {
            Text(
                timerInterval: .now...Date(timeIntervalSinceNow: 90),
                countsDown: true
            )
            
            Text(
                timerInterval: .now...Date(timeIntervalSinceNow: 90),
                countsDown: false
            )
        }
        .font(.system(size: 150, weight: .black))
        .italic()
    }
}

#Preview {
    CountDownExample()
}
