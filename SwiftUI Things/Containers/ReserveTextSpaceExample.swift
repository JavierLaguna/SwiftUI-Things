
import SwiftUI

struct ReserveTextSpaceExample: View {
    
    var body: some View {
        VStack(spacing: 32) {
            Text("No reserved space text!")
                .lineLimit(2)
                .background(.mint)
            
            Text("Reserved space text!")
                .lineLimit(2, reservesSpace: true)
                .background(.mint)
            
        }
        .font(.largeTitle)
    }
}

#Preview {
    ReserveTextSpaceExample()
}
