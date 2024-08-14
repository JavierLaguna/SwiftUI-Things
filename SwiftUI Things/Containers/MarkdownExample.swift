
import SwiftUI

struct MarkdownExample: View {
    
    let textContent: LocalizedStringKey = """
    **Creating a Text View in SwiftUI**

    *The example below shows how to create a simple text view:*

    
    `Text("Hello, World!")`
    
    
    This is a SwiftUI Things example [Github](https://github.com/JavierLaguna/SwiftUI-Things).
    """
    
    var body: some View {
        Text(textContent)
            .font(.title)
            .padding()
    }
}

#Preview {
    MarkdownExample()
}
