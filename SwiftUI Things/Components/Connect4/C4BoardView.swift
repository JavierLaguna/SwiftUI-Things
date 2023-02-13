
import SwiftUI

struct C4BoardView: View {
    
    private let rowHoles: Int
    private let columnHoles: Int
    
    init(rowHoles: Int, columnHoles: Int) {
        self.rowHoles = rowHoles
        self.columnHoles = columnHoles
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(1...columnHoles, id: \.self) { _ in
                C4RowView(numOfHoles: rowHoles)
            }
        }
    }
}

struct C4BoardView_Previews: PreviewProvider {
    
    static var previews: some View {
        C4BoardView(rowHoles: 7, columnHoles: 6)
            .previewLayout(.sizeThatFits)
    }
}
