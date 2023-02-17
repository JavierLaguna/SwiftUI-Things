
import Foundation

final class C4GameViewModel: ObservableObject {
    
    static let initialPlayer: C4PlayerType = .red
    
    private let player1: C4PlayerType = .red
    private let player2: C4PlayerType = .white
    
    let columnHoles = 6
    let rowHoles = 7
    
    // [Column][Row]
    @Published var grid = [[C4PlayerType?]]()
    @Published var currentPlayer: C4PlayerType = initialPlayer
    @Published var winner: C4PlayerType?
    @Published var boardIsFull = false
    
    init() {
        initGrid()
    }
    
    func canFillHole(on row: Int) -> Int? {
        for (column, _) in grid.enumerated().reversed() {
            if grid[column][row] == nil {
                return column
            }
        }
        
        return nil
    }
    
    func fillHole(column: Int, row: Int) {
        for (column, _) in grid.enumerated().reversed() {
            if grid[column][row] == nil {
                grid[column][row] = currentPlayer
                break
            }
        }
        
        if checkIfPlayerConnect4() {
            winner = currentPlayer
        } else if checkIfBoardIsFull() {
            boardIsFull = true
        } else {
            changePlayer()
        }
    }
    
    func restartGame() {
        initGrid()
        currentPlayer = C4GameViewModel.initialPlayer
        winner = nil
        boardIsFull = false
    }
}

// MARK: Private functions
private extension C4GameViewModel {
    
    func initGrid() {
        var initialGrid = [[C4PlayerType?]]()
        for column in 0..<columnHoles {
            initialGrid.append([])
            
            for _ in 0..<rowHoles {
                initialGrid[column].append(nil)
            }
        }
        
        grid = initialGrid
    }
    
    func changePlayer() {
        currentPlayer = currentPlayer == player1 ? player2 : player1
    }
    
    func checkIfBoardIsFull() -> Bool {
        return Array(grid.joined()).first(where: { $0 == nil }) == nil
    }
    
    func checkIfPlayerConnect4() -> Bool {
        return checkRows() || checkColums() || checkDiagonals()
    }
    
    func checkRows() -> Bool {
        for row in grid {
            var count = 1
            var index = 0
            while index < row.count - 1 {
                if row[index] != nil && row[index] == row[index+1] {
                    count += 1
                    if count == 4 {
                        print("Hay cuatro valores \(row[index]) iguales consecutivos en una fila")
                        return true
                    }
                } else {
                    count = 1
                }
                index += 1
            }
        }
        
        return false
    }
    
    func checkColums() -> Bool {
        for columnIndex in 0..<grid[0].count {
            var count = 1
            var index = 0
            while index < grid.count - 1 {
                let currentValue = grid[index][columnIndex]
                let nextValue = grid[index+1][columnIndex]
                if currentValue != nil && currentValue == nextValue {
                    count += 1
                    if count == 4 {
                        print("Hay cuatro valores \(currentValue) iguales consecutivos en una columna")
                        return true
                    }
                } else {
                    count = 1
                }
                index += 1
            }
        }
        
        return false
    }
    
    func checkDiagonals() -> Bool {
        for rowIndex in 0..<grid.count {
            for columnIndex in 0..<grid[0].count {
                if let value = grid[rowIndex][columnIndex] {
                    if rowIndex <= grid.count - 4 && columnIndex <= grid[0].count - 4 {
                        if value == grid[rowIndex + 1][columnIndex + 1] &&
                            value == grid[rowIndex + 2][columnIndex + 2] &&
                            value == grid[rowIndex + 3][columnIndex + 3] {
                            print("Hay cuatro valores \(value) iguales consecutivos en una diagonal")
                            return true
                        }
                    }
                    if rowIndex >= 3 && columnIndex <= grid[0].count - 4 {
                        if value == grid[rowIndex - 1][columnIndex + 1] &&
                            value == grid[rowIndex - 2][columnIndex + 2] &&
                            value == grid[rowIndex - 3][columnIndex + 3] {
                            print("Hay cuatro valores \(value) iguales consecutivos en una diagonal")
                            return true
                        }
                    }
                }
            }
        }
        
        return false
    }
}
