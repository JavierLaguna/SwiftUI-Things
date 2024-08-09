import SwiftUI

struct DisplayArrayUserFriendlyExample: View {
    
    private let items = [
        "iPad Pro",
        "iPad Air",
        "iPad mini",
    ]
    
    var body: some View {
        List {
            Section("No friendly") {
                Text("\(items)")
            }
            
            Section("Type list + and") {
                Text(items.formatted(.list(type: .and)))
            }
            
            Section("Type list + or") {
                Text(items.formatted(.list(type: .or)))
            }
        }
    }
}

#Preview {
    DisplayArrayUserFriendlyExample()
}
