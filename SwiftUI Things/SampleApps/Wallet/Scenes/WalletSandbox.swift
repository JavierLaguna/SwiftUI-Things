
import SwiftUI

struct WalletSandbox: View {
    
    var body: some View {
        WalletMainView()
            .navigationBarHidden(true)
    }
}

struct WalletSandbox_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            WalletSandbox()
                .navigationTitle("navTitle")
        }
    }
}
