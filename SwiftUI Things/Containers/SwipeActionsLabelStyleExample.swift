import SwiftUI

extension SwipeActionsLabelStyleExample: NativeModifiersThing {
    static let title = "Swipe actions LabelStyle"
    static func makeView() -> some View { Self() }
}

struct SwipeActionsLabelStyleExample: View {
    
    let fruits = ["Apple", "Orange", "Banana"]
    
    var body: some View {
        List {
            
            // MARK: - Title + Icon
            Section("Title + Icon") {
                ForEach(fruits, id: \.self) { fruit in
                    Text(fruit)
                        .swipeActions(edge: .trailing) {
                            Button(
                                "Delete",
                                systemImage: "trash",
                                role: .destructive
                            ) {
                                print("Delete \(fruit)")
                            }
                            .labelStyle(.titleAndIcon)
                        }
                }
            }
            
            // MARK: - Icon Only
            Section("Icon Only") {
                ForEach(fruits, id: \.self) { fruit in
                    Text(fruit)
                        .swipeActions(edge: .trailing) {
                            Button(
                                "Delete",
                                systemImage: "trash",
                                role: .destructive
                            ) {
                                print("Delete \(fruit)")
                            }
                            .labelStyle(.iconOnly)
                        }
                }
            }
            
            // MARK: - Title Only
            Section("Title Only") {
                ForEach(fruits, id: \.self) { fruit in
                    Text(fruit)
                        .swipeActions(edge: .trailing) {
                            Button(
                                "Delete",
                                systemImage: "trash",
                                role: .destructive
                            ) {
                                print("Delete \(fruit)")
                            }
                            .labelStyle(.titleOnly)
                        }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    SwipeActionsLabelStyleExample()
}
