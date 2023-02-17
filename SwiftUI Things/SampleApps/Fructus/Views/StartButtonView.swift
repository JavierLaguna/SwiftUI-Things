
import SwiftUI 

struct StartButtonView: View {
    
    @AppStorage(Constants.AppStorage.fructusOnboarding) var isOnboarding: Bool?
    
    var body: some View {
        Button(action: {
            isOnboarding = false
        }) {
            HStack(spacing: 8) {
                Text("Start")
                
                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule().strokeBorder(Color.white, lineWidth: 1.25)
            )
        }
        .accentColor(Color.white)
    }
}

// MARK: - PREVIEW
struct StartButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        StartButtonView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
