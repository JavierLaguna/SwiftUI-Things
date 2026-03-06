import SwiftUI

extension FructusApp: SampleAppThing {
    static let title = "Fructus"
    static func makeView() -> some View { Self() }
}

struct FructusApp: View {
    
    @AppStorage(Constants.AppStorage.fructusOnboarding) var isOnboarding: Bool = true
    
    var body: some View {
        Group {
            if isOnboarding {
                FructusOnboardingView()
            } else {
                FructusContentView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
