
import SwiftUI

struct C4BoardView: View {
    
    private let grid: [[C4PlayerType?]]
    private let rowHoles: Int
    private let columnHoles: Int
    
    init(grid: [[C4PlayerType?]], rowHoles: Int, columnHoles: Int) {
        self.grid = grid
        self.rowHoles = rowHoles
        self.columnHoles = columnHoles
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<columnHoles, id: \.self) { columnIndex in
                C4RowView(row: grid[columnIndex], numOfHoles: rowHoles)
            }
        }
    }
}

struct C4BoardView_Previews: PreviewProvider {
    
    static var previews: some View {
        C4BoardView(grid: [], rowHoles: 7, columnHoles: 6)
            .previewLayout(.sizeThatFits)
    }
}
