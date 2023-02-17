
import SwiftUI

struct C4RowView: View {
    
    private let row: [C4PlayerType?]
    private let numOfHoles: Int
    
    init(row: [C4PlayerType?], numOfHoles: Int) {
        self.row = row
        self.numOfHoles = numOfHoles
    }
    
    private var holeSize: Double {
        Double(UIScreen.main.bounds.width) / Double(numOfHoles)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<numOfHoles, id: \.self) { holeIndex in
                C4HoleView(size: holeSize, filledColor: row[holeIndex]?.color)
            }
        }
    }
}

struct C4RowView_Previews: PreviewProvider {
    
    static var previews: some View {
        C4RowView(row: [], numOfHoles: 6)
            .previewLayout(.sizeThatFits)
    }
}
