
import SwiftUI

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
