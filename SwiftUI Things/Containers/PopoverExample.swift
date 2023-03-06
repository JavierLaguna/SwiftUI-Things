
import SwiftUI

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

struct PopoverExample_Previews: PreviewProvider {
    
    static var previews: some View {
        PopoverExample()
    }
}
