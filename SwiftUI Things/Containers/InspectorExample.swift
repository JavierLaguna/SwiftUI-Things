import SwiftUI

extension InspectorExample: NativeModifiersThing {
    static let title = "Inspector"
    static func makeView() -> some View { Self() }
}

struct InspectorExample: View {
    
    @State private var showInspector = false
    
    var body: some View {
        Button {
            showInspector.toggle()
            
        } label: {
            Image(systemName: "gamecontroller")
                .font(.system(size: 120))
                .foregroundStyle(.purple, .gray)
        }
        .inspector(isPresented: $showInspector) {
            Text("More options for this controller")
        }
    }
}

#Preview {
    InspectorExample()
}
