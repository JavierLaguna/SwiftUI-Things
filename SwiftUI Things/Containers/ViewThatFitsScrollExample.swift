
import SwiftUI

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

struct ViewThatFitsScrollExample_Previews: PreviewProvider {
    
    static var previews: some View {
        ViewThatFitsScrollExample(count: 100)
            .previewDisplayName("Text")
        
        ViewThatFitsScrollExample(count: 300)
            .previewDisplayName("ScrollView+Text")
    }
}
