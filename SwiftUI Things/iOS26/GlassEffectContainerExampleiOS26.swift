import SwiftUI

struct GlassEffectContainerExampleiOS26: View {
    
    enum Effect: String, CaseIterable {
        case matchedGeometry
        case materialize
        case identity
        
        @available(iOS 26.0, *)
        var transition: GlassEffectTransition {
            switch self {
            case .matchedGeometry: .matchedGeometry
            case .materialize: .materialize
            case .identity: .identity
            }
        }
    }
    
    @State private var selectedOption: Effect = .matchedGeometry
    @State private var isExpanded = false
    
    var body: some View {
        if #available(iOS 26.0, *) {
            ScrollView {
                Text("glassEffectTransition")
                    .font(.title)
                
                Picker("glassEffectTransition", selection: $selectedOption) {
                    ForEach(Effect.allCases, id: \.self) { item in
                        Text("\(item.rawValue)").tag(item)
                    }
                }
                .pickerStyle(.segmented)
            }
            .navigationTitle("glassEffect Examples")
            .overlay(alignment: .bottomTrailing, content: {
                GlassEffectContainer {
                    VStack {
                        if isExpanded {
                            Button {} label: {
                                Image(systemName: "bandage")
                            }
                            
                            Button {} label: {
                                Image(systemName: "hammer")
                            }
                            
                            Button {} label: {
                                Image(systemName: "wrench")
                            }
                        }
                        
                        Button {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        } label: {
                            Image(systemName: isExpanded ? "xmark" : "ellipsis")
                                .font(.title)
                        }
                    }
                    .padding(24)
                    .buttonStyle(.glass)
                    .buttonBorderShape(.circle)
                    .controlSize(.large)
                    .glassEffectTransition(selectedOption.transition)
                }
            })
            .background {
                Image(.iOS26Light)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            
        } else {
            Text("iOS 26 device required")
        }
    }
}

#Preview {
    GlassEffectContainerExampleiOS26()
}
