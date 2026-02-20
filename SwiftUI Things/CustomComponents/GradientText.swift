import SwiftUI

extension GradientText: CustomComponentThing {
    static let title = "GradientText"
    static func makeView() -> some View { Self() }
}

struct GradientText: View {
    
    var body: some View {
        VStack {
            Text("iOS")
                .font(.system(size: 180))
                .fontWeight(.black)
                .foregroundStyle(.teal.gradient)
            
            Text("iOS")
                .font(.system(size: 180))
                .fontWeight(.black)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.pink, .purple, .blue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                )
        }
    }
}

struct GradientText_Previews: PreviewProvider {
    
    static var previews: some View {
        GradientText()
    }
}
