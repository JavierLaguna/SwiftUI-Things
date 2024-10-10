
import SwiftUI

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
