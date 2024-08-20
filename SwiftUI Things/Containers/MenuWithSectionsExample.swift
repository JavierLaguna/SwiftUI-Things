import SwiftUI

struct MenuWithSectionsExample: View {
    
    var body: some View {
        Menu {
            Section {
                Button {
                    // Empty
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
                
                Button {
                    // Empty
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
            
            Section("Section name") {
                Button {
                    // Empty
                } label: {
                    Label("More", systemImage: "ellipsis")
                }
            }
            
            Section {
                Button(role: .destructive) {
                    // Empty
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
            
        } label: {
            Label("More", systemImage: "ellipsis.circle")
                .foregroundStyle(.purple)
        }
        .menuOrder(.fixed)
    }
}

#Preview {
    MenuWithSectionsExample()
}
