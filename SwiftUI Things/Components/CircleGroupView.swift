
import SwiftUI

struct CircleGroupView: View {
    
    private let circleSize: CGFloat = 260
    
    @State var ShapeColor: Color
    @State var ShapeOpacity: Double
    @State private var didAppear: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
                .frame(width: circleSize, height: circleSize, alignment: .center)
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
                .frame(width: circleSize, height: circleSize, alignment: .center)
        }
        .blur(radius: didAppear ? 0 : 10)
        .opacity(didAppear ? 1 : 0)
        .scaleEffect(didAppear ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: didAppear)
        .onAppear(perform: {
            didAppear = true
        })
    }
}

struct CircleGroupViewSandbox: View {
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
        }
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleGroupView(ShapeColor: .orange, ShapeOpacity: 0.2)
            .previewLayout(.sizeThatFits)
            
            CircleGroupViewSandbox()
                .previewDisplayName("Sanbox")
        }
    }
}
