import SwiftUI

struct RenameButtonExample: View {
    
    var body: some View {
        RenameButton()
            .renameAction {
                print("rename something")
            }
    }
}

#Preview {
    RenameButtonExample()
}
