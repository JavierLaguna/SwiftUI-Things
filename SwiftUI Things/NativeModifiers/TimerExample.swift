import SwiftUI

extension TimerExample: NativeModifiersThing {
    static let title = "Timer"
    static func makeView() -> some View { Self() }
}

struct TimerExample: View {
    
    var body: some View {
        Text(.now, style: .timer)
            .font(.largeTitle.bold())
            .foregroundStyle(.colorPomegranateDark)
    }
}

#Preview {
    TimerExample()
}
