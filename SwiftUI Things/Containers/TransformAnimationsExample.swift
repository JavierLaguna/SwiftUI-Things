
import SwiftUI

struct TransformAnimationsExample: View {
    
    @State private var show = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 260, height: 200)
                .offset(y: 20)
            
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 300, height: 200)
                .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                .offset(y: show ? -200 : 0)
                .scaleEffect(show ? 1.2 : 1)
                .rotationEffect(Angle(degrees: show ? 30 : 0))
                .rotation3DEffect(
                    Angle(degrees: show ? 30 : 0),
                    axis: (x: 1, y: 0, z: 0),
                    anchor: .center,
                    anchorZ: 0.0,
                    perspective: 1
                )
                .onTapGesture {
                    withAnimation(.spring()) {
                        show.toggle()
                    }
                }
        }
    }
}

struct TransformAnimationsExample_Previews: PreviewProvider {
    
    static var previews: some View {
        TransformAnimationsExample()
    }
}
