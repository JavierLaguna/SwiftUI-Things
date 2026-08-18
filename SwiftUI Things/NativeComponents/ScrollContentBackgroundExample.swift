import SwiftUI
import iOS26Macros

extension ScrollContentBackgroundExample: NativeComponentThing {
    static let title = "Scroll Content Background"
    static func makeView() -> some View { Self() }
}

struct ScrollContentBackgroundExample: View {
    
    let tasks = [
        "Plan the day",
        "Review project ideas",
        "Create something new",
        "Take a short break",
        "Reflect on today"
    ]
    
    var body: some View {
        NavigationStack {
            List(tasks, id: \.self) { task in
                Text(task)
            }
            .navigationTitle("Daily Focus")
            .scrollContentBackground(.hidden)
            .background(
                Image(.iOS26Light)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    ScrollContentBackgroundExample()
}
