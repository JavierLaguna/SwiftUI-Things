import SwiftUI

struct DetectTapLocationExample: View {
    
    @State private var tappedLocation: CGPoint = .zero
    
    var body: some View {
        Color.gray.opacity(0.3)
            .frame(width: 300, height: 400)
            .overlay {
                VStack {
                    Text("Tapped on")
                    Text("X: \(tappedLocation.x)")
                    Text("Y: \(tappedLocation.y)")
                }
            }
            .onTapGesture { location in
                tappedLocation = location
                print("User tapped at coordinates \(location)")
            }
    }
}

#Preview {
    DetectTapLocationExample()
}
