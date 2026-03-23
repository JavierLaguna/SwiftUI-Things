import SwiftUI

extension RenameButtonExample: NativeComponentThing {
    static let title = "RenameButton"
    static func makeView() -> some View { Self() }
}

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
