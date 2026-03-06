import SwiftUI

extension PopoverExample: NativeModifiersThing {
    static let title = "Popover"
    static func makeView() -> some View { Self() }
}

struct PopoverExample: View {
    
    @State private var showPopover = false
    
    var body: some View {
        Button(action: {
            showPopover.toggle()
        }) {
            Text("Show Popover")
        }
        .popover(isPresented: $showPopover, attachmentAnchor: .point(.top)) {
            PopoverView()
        }
    }
}

private struct PopoverView: View {
    
    var body: some View {
        VStack {
            Text("👋🏻")
        }
        .presentationCompactAdaptation(.none)
    }
}

#Preview {
    PopoverExample()
}
