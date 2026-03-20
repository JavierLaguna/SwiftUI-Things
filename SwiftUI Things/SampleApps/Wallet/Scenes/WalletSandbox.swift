import SwiftUI

extension WalletSandbox: SampleAppThing {
    static let title = "Wallet"
    static func makeView() -> some View { Self() }
}

struct WalletSandbox: View {
    
    var body: some View {
        WalletMainView()
            .navigationBarHidden(true)
    }
}

#Preview {
    NavigationView {
        WalletSandbox()
            .navigationTitle("navTitle")
    }
}
