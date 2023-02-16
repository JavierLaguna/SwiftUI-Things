
import SwiftUI

struct C4GameView: View {
    
    private let sheetSize: CGFloat = 34
    private let sheetMaxY: CGFloat = 170
    
    @ObservedObject private var viewModel = C4GameViewModel()
    
    @State private var sheetX: CGFloat = UIScreen.main.bounds.width / 2
    @State private var sheetY: CGFloat = 50
    
    
    private func onReleaseSheet() {
        if sheetY >= sheetMaxY {
            let space = Double(UIScreen.main.bounds.width) / Double(viewModel.rowHoles)
            
            var rowHole: Double = 0 // TODO: JLI Column ??
            for hole in 0...viewModel.rowHoles - 1 {
                let position = Double(hole)
                
                if sheetX >= space * position,
                   sheetX <= space * (position + 1) {
                    rowHole = position
                    break
                }
            }
            
            let holeX = space / 2 + rowHole * space
            
            viewModel.fillHole(on: Int(rowHole))
            
            withAnimation(.linear(duration: 0.5)) {
                sheetX = holeX
                sheetY = 520
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
                            sheetX = gesture.location.x
                            
                            if gesture.location.y < sheetMaxY {
                                sheetY = gesture.location.y
                            } else if gesture.location.y <= 0 {
                                sheetY = 0
                            } else {
                                sheetY = sheetMaxY
                            }
                        }
                        .onEnded { _ in
                            onReleaseSheet()
                        }
                )
            
            C4BoardView(rowHoles: viewModel.rowHoles, columnHoles: viewModel.columnHoles)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct C4GameView_Previews: PreviewProvider {
    
    static var previews: some View {
        C4GameView()
    }
}
