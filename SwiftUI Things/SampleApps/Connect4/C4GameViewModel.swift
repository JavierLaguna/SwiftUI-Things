
import Foundation

final class C4GameViewModel: ObservableObject {
    
    let columnHoles = 6
    let rowHoles = 7
    
    // [Column][Row]
    @Published var grid = [[Bool?]]()
    
    init() {
        initGrid()
    }
    
    private func initGrid() {
        var initialGrid = [[Bool?]]()
        for column in 0..<columnHoles {
            initialGrid.append([])
            
            for _ in 0..<rowHoles {
                initialGrid[column].append(nil)
            }
        }
        
        grid = initialGrid
    }
    
    func fillHole(on column: Int) {
        guard let lastAvilableRowHole = grid[column].lastIndex(where: { $0 == nil }) else {
            return
        }
        
        grid[column][lastAvilableRowHole] = true
    }
}
