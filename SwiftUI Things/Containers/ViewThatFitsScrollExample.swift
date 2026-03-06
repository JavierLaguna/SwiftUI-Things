import SwiftUI

extension ViewThatFitsScrollExample: NativeComponentThing {
    static let title = "ViewThatFitsScroll"
    static func makeView() -> some View { Self(count: 220)
    }
}

struct ViewThatFitsScrollExample: View {
    
    private let terms: String
    
    init(count: Int) {
        terms = String(repeating: "abcde ", count: count)
    }
    
    var body: some View {
        ViewThatFits(in: .vertical) {
            Text(terms)
            
            ScrollView {
                Text(terms)
            }
        }
    }
}

#Preview("Text") {
    ViewThatFitsScrollExample(count: 100)
}

#Preview("ScrollView+Text") {
    ViewThatFitsScrollExample(count: 300)
}
