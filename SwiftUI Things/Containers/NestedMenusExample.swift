import SwiftUI

struct NestedMenusExample: View {
    
    var body: some View {
        Menu {
            Button(role: .destructive) {
                // Empty
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
            Menu {
                Button("Share with Friends") {
                    // Empty
                }
                
                Button("Share on Device") {
                    // Empty
                }
            } label: {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            
            Button {
                // Empty
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            
        } label: {
            Label("More", systemImage: "ellipsis.circle")
                .foregroundStyle(.purple)
        }
    }
}

#Preview {
    NestedMenusExample()
}
