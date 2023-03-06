
import SwiftUI

struct AdvancedMatchedGeometryEffectExample: View {
    
    @Namespace private var namespace
    @State private var show = false
    
    var body: some View {
        ZStack {
            if show {
                PlayView(namespace: namespace)
                
            } else {
                VStack {
                    HStack(spacing: 16) {
                        RoundedRectangle(cornerRadius: 10)
                            .matchedGeometryEffect(id: AdvancedMatchedGeometryEffectExample.shapeMGEId, in: namespace)
                            .frame(width: 44)
                        
                        Text("Fever")
                            .matchedGeometryEffect(id: AdvancedMatchedGeometryEffectExample.titleMGEId, in: namespace)
                        
                        Spacer()
                        
                        Image(systemName: "play.fill")
                            .matchedGeometryEffect(id: AdvancedMatchedGeometryEffectExample.playMGEId, in: namespace)
                            .font(.title)
                        
                        Image(systemName: "forward.fill")
                            .matchedGeometryEffect(id: AdvancedMatchedGeometryEffectExample.forwardMGEId, in: namespace)
                            .font(.title)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 44)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.blue)
                        .matchedGeometryEffect(id: AdvancedMatchedGeometryEffectExample.backgroundMGEId, in: namespace)
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .foregroundColor(.white)
        .onTapGesture {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) {
                show.toggle()
            }
        }
    }
}

extension AdvancedMatchedGeometryEffectExample {
    static let shapeMGEId = "shape"
    static let titleMGEId = "title"
    static let playMGEId = "play"
    static let forwardMGEId = "forward"
    static let backgroundMGEId = "background"
}

private struct PlayView: View {
    
    private var namespace: Namespace.ID
    
    init(namespace: Namespace.ID) {
        self.namespace = namespace
    }
    
    var body: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 30)
                .matchedGeometryEffect(id: AdvancedMatchedGeometryEffectExample.shapeMGEId, in: namespace)
                .frame(height: 300)
                .padding()
            
            Text("Fever")
                .matchedGeometryEffect(id: AdvancedMatchedGeometryEffectExample.titleMGEId, in: namespace)
            
            HStack {
                Image(systemName: "play.fill")
                    .matchedGeometryEffect(id: AdvancedMatchedGeometryEffectExample.playMGEId, in: namespace)
                    .font(.title)
                
                Image(systemName: "forward.fill")
                    .matchedGeometryEffect(id: AdvancedMatchedGeometryEffectExample.forwardMGEId, in: namespace)
                    .font(.title)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.blue)
                .matchedGeometryEffect(id: AdvancedMatchedGeometryEffectExample.backgroundMGEId, in: namespace)
        )
        .ignoresSafeArea()
    }
}

struct AdvancedMatchedGeometryEffectExample_Previews: PreviewProvider {
    
    static var previews: some View {
        AdvancedMatchedGeometryEffectExample()
    }
}

struct PlayView_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        PlayView(namespace: namespace)
    }
}
