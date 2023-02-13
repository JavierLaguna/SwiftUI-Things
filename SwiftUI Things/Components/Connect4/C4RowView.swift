
import SwiftUI

struct C4RowView: View {
    
    private let numOfHoles: Int
    
    init(numOfHoles: Int) {
        self.numOfHoles = numOfHoles
    }
    
    private var holeSize: Double {
        Double(UIScreen.main.bounds.width) / Double(numOfHoles)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1...numOfHoles, id: \.self) { _ in
                C4HoleView(size: holeSize)
            }
        }
    }
}

struct C4RowView_Previews: PreviewProvider {
    
    static var previews: some View {
        C4RowView(numOfHoles: 6)
            .previewLayout(.sizeThatFits)
    }
}
