
import Foundation

final class C4GameViewModel: ObservableObject {
    
    let rowHoles = 7
    let columnHoles = 6
    
    @Published var grid = [[Bool?]]()
    
    private func initGrid() {
        
    }
    
    func fillHole(on column: Int) {
        
    }
}
