import SwiftUI

extension View {
    
    func stretchyVisualEffect() -> some View {
        visualEffect { effect, geometry in
            let currentHeight = geometry.size.height
            let scrollOffset = geometry.frame(in: .scrollView).minY
            let positiveOffset = max(0, scrollOffset)
            
            let newHeight = currentHeight + positiveOffset
            let scaleFactor = newHeight / currentHeight
            
            return effect.scaleEffect(
                x: scaleFactor, y: scaleFactor,
                anchor: .bottom
            )
        }
    }
}

struct StretchyVisualEffect: View {
    
    var body: some View {
            ScrollView {
                VStack {
                    Image("sonoma")
                        .resizable()
                        .scaledToFill()
                        .stretchyVisualEffect()
                    
                    Text(
                    """
                    Lorem ipsum dolor sit amet consectetur adipiscing, elit cubilia maecenas inceptos rutrum hac, sed faucibus interdum commodo curabitur. Gravida felis leo ut habitant eget in nam turpis vitae, quam taciti nullam aliquet rhoncus quisque dictumst fusce mattis, vel dui maecenas enim morbi sociosqu himenaeos erat. Fusce penatibus dictum pellentesque odio sagittis lobortis fermentum hendrerit mattis placerat, vel sociis facilisi tortor quisque tempus nisi mus primis, iaculis nisl ac egestas leo pulvinar ante quam vulputate.

                    Augue pretium sodales vestibulum lectus interdum scelerisque, orci convallis curabitur feugiat phasellus, curae imperdiet mollis volutpat aliquet. Placerat augue tempus integer dui ante mus vitae, litora urna interdum nulla elementum massa, est sociis porttitor volutpat laoreet viverra. Orci diam conubia nisl quisque eu ornare nulla, faucibus pulvinar congue rhoncus purus dapibus, turpis justo aliquam nullam eleifend vulputate.                        
                    """
                    )
                }
            }
            .ignoresSafeArea(edges: .top)
        }
}

#Preview {
    StretchyVisualEffect()
}
