import SwiftUI

extension TextSelectionExample: NativeModifiersThing {
    static let title = "TextSelection"
    static func makeView() -> some View { Self() }
}

struct TextSelectionExample: View {
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .textSelection(.enabled)
    }
}

#Preview {
    TextSelectionExample()
}
