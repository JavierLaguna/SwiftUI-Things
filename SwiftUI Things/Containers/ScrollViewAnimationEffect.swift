import SwiftUI

struct ScrollViewAnimationEffect: View {
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack(spacing: 16) {
                    ForEach(0...50, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.purple)
                            .overlay {
                                Text("\(index)")
                                    .font(.system(size: 60, weight: .bold, design: .rounded))
                            }
                            .frame(height: 100)
                            .visualEffect { content, proxy in
                                return content.hueRotation(.degrees(proxy.frame(in: .global).midY / 8))
                            }
                            .scrollTransition(.animated) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.2)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.2)
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewAnimationEffect()
}
