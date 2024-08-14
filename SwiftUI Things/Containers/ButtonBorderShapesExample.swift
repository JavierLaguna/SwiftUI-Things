
import SwiftUI

struct ButtonBorderShapesExample: View {
    
    @ViewBuilder
    private func buttonExample(name: String, buttonBorderShape: ButtonBorderShape) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(name)
                .font(.title2.bold())
            
            Button(action: {
                // Empty
            }, label: {
                Image(systemName: "trash")
            })
            .tint(.red)
            .buttonStyle(.bordered)
            .buttonBorderShape(buttonBorderShape)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            buttonExample(name: "roundedRectangle", buttonBorderShape: .roundedRectangle)
            buttonExample(name: "roundedRectangle custom radius", buttonBorderShape: .roundedRectangle(radius: 2))
            buttonExample(name: "capsule", buttonBorderShape: .capsule)
            buttonExample(name: "circle", buttonBorderShape: .circle)
        }
    }
}

#Preview {
    ButtonBorderShapesExample()
}
