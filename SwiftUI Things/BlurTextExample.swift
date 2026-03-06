import SwiftUI

extension BlurTextExample: NativeModifiersThing {
    static let title = "Blur Text"
    static func makeView() -> some View { Self() }
}

struct BlurTextExample: View {
    
    var body: some View {
        HStack {
            Text("This is")
            
            Text("blurred")
                .blur(radius: 5)
            
            Text("text")
        }
    }
}

#Preview {
    BlurTextExample()
}
