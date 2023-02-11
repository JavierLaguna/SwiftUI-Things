
import SwiftUI

struct RestartMainView: View {
    
    @AppStorage(Constants.AppStorage.restartOnboarding) var isOnboardingViewActive: Bool = true
    
    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                RestartOnboardingView()
            } else {
                RestartHomeView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RestartMainView_Previews: PreviewProvider {
    
    static var previews: some View {
        RestartMainView()
    }
}
