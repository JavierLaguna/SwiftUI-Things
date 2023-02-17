
import SwiftUI

struct C4GameView: View {
    
    static let initialSheetX: CGFloat = UIScreen.main.bounds.width / 2
    static let initialSheetY: CGFloat = 50
    
    private let hapticFeedback = UINotificationFeedbackGenerator()
    private let sheetSize: CGFloat = 34
    private let sheetMinY: CGFloat = initialSheetY - 20
    
    @ObservedObject private var viewModel = C4GameViewModel()
    
    @State private var boardHeight: CGFloat = 0
    @State private var sheetX: CGFloat = initialSheetX
    @State private var sheetY: CGFloat = initialSheetY
    
    private var holeWidth: Double {
        Double(UIScreen.main.bounds.width) / Double(viewModel.rowHoles)
    }
    
    private var holeHeight: Double {
        boardHeight / Double(viewModel.columnHoles)
    }
    
    private var spaceToBoardTop: Double {
        Double(UIScreen.main.bounds.height) / 2 - holeHeight * 4
    }
    
    private func onReleaseSheet() {
        if sheetY >= spaceToBoardTop {
            
            var rowHole: Double = 0
            for hole in 0...viewModel.rowHoles - 1 {
                let position = Double(hole)
                
                if sheetX >= holeWidth * position,
                   sheetX <= holeWidth * (position + 1) {
                    rowHole = position
                    break
                }
            }
            
            if let columnHole = viewModel.canFillHole(on: Int(rowHole)) {
                let holeY = holeHeight / 2 + Double(columnHole) * holeHeight + spaceToBoardTop
                let holeX = holeWidth / 2 + rowHole * holeWidth
                
                let animationDuration = 0.5
                withAnimation(.linear(duration: animationDuration)) {
                    sheetX = holeX
                    sheetY = holeY
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                    viewModel.fillHole(column: columnHole, row: Int(rowHole))
                    
                    sheetX = C4GameView.initialSheetX
                    sheetY = C4GameView.initialSheetY
                    
                    hapticFeedback.notificationOccurred(.success)
                }
            } else {
                hapticFeedback.notificationOccurred(.error)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(viewModel.currentPlayer.color)
                .frame(width: sheetSize, height: sheetSize)
                .shadow(radius: 4)
                .position(x: sheetX, y: sheetY)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            guard viewModel.winner == nil else {
                                return
                            }
                            
                            sheetX = gesture.location.x
                            
                            if gesture.location.y <= sheetMinY {
                                sheetY = sheetMinY
                            } else if gesture.location.y < spaceToBoardTop {
                                sheetY = gesture.location.y
                            } else {
                                sheetY = spaceToBoardTop
                            }
                        }
                        .onEnded { _ in
                            onReleaseSheet()
                        }
                )
            
            C4BoardView(
                grid: viewModel.grid,
                rowHoles: viewModel.rowHoles,
                columnHoles: viewModel.columnHoles
            )
            .modifier(GetHeightModifier(height: $boardHeight))
            
            if let winner = viewModel.winner {
                Rectangle()
                    .background(.thinMaterial)
                    .ignoresSafeArea(.all)
                
                VStack {
                    Text("🎉🎊 WINNER 🎊🎉")
                        .font(.largeTitle)
                    
                    Circle()
                        .fill(winner.color)
                        .frame(width: sheetSize * 2, height: sheetSize * 2)
                        .shadow(radius: 4)
                    
                    Button("Restart") {
                        viewModel.restartGame()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 60)
                }
            }
            
            if viewModel.boardIsFull {
                Rectangle()
                    .background(.thinMaterial)
                    .ignoresSafeArea(.all)
                
                VStack {
                    Text("☹️ Board is full... 🔴⚪️")
                        .font(.largeTitle)
                    
                    Button("Restart") {
                        viewModel.restartGame()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 60)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(.orange)
    }
}

struct C4GameView_Previews: PreviewProvider {
    
    static var previews: some View {
        C4GameView()
    }
}
