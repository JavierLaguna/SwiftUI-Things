import SwiftUI

extension ImageAndTextExample: NativeComponentThing {
    static let title = "Image and text"
    static func makeView() -> some View { Self() }
}

struct ImageAndTextExample: View {
    
    var body: some View {
        Text("SwiftUI ")
        +
        Text(Image(systemName: "apple.logo"))
            .foregroundStyle(.colorGrapefruitDark)
            .font(.title)
        +
        Text(" Things!!")
    }
}

#Preview {
    ImageAndTextExample()
}
