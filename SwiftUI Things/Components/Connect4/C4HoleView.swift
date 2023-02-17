
import SwiftUI

struct C4HoleView: View {
    
    private let size: CGFloat
    private let filledColor: Color?
    
    init(size: CGFloat, filledColor: Color? = nil) {
        self.size = size
        self.filledColor = filledColor
    }
    
    var body: some View {
        ZStack {
            if let filledColor {
                Circle()
                    .fill(filledColor)
                    .frame(width: 30, height: 30)
            }
            
            Circle()
                .stroke(Color.blue, lineWidth: 22)
                .frame(width: size, height: size, alignment: .center)
                .clipped()
        }
    }
}

struct C4HoleView_Previews: PreviewProvider {
    static var previews: some View {
        C4HoleView(size: 80)
            .previewLayout(.sizeThatFits)
    }
}
