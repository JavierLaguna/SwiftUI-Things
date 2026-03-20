import SwiftUI

extension RestartMainView: SampleAppThing {
    static let title = "Restart"
    static func makeView() -> some View { Self() }
}

struct RestartMainView: View {
    
    @AppStorage(Constants.AppStorage.restartOnboarding) var isOnboardingViewActive: Bool = true
    
    var body: some View {
        Group {
            if isOnboardingViewActive {
                RestartOnboardingView()
            } else {
                RestartHomeView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RestartMainView()
}
