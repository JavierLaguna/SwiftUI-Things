import SwiftUI
import iOS26Macros

extension OutlineGroupExample: NativeComponentThing {
    static let title = "Outline Group"
    static func makeView() -> some View { Self() }
}

struct OutlineGroupExample: View {
    
    private let items: [OutlineItem] = [
        OutlineItem(
            title: "Fruits",
            children: [OutlineItem(title: "Apple"), OutlineItem(title: "Banana")]
        ),
        OutlineItem(
            title: "Vegetables",
            children: [OutlineItem(title: "Carrot"), OutlineItem(title: "Tomato")]
        )
    ]
    
    var body: some View {
        List {
            OutlineGroup(items, children: \.children) { item in
                Text(item.title)
            }
        }
    }
}

private struct OutlineItem: Identifiable {
    let id = UUID()
    let title: String
    var children: [OutlineItem]? = nil
}

#Preview {
    OutlineGroupExample()
}
