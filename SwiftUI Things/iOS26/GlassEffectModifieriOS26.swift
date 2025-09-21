import SwiftUI

struct GlassEffectModifieriOS26: View {
    
    var body: some View {
        if #available(iOS 26.0, *) {
            ScrollView {
                VStack(spacing: 16) {
                    // MARK: .regular
                    HStack {
                        Text("default / .regular")
                            .font(.title2)
                        Spacer()
                    }
                    
                    Text("glassEffect")
                        .padding()
                        .glassEffect()
                    
                    Text(".glassEffect(.regular.interactive())")
                        .padding()
                        .glassEffect(.regular.interactive())
                    
                    Text(".glassEffect(.regular.interactive(), in: .rect)")
                        .padding()
                        .glassEffect(.regular.interactive(), in: .rect)
                    
                    Text(".glassEffect(.regular.tint(.orange))")
                        .padding()
                        .glassEffect(.regular.tint(.orange))
                    
                    Text(".glassEffect(.regular.tint(.orange).interactive())")
                        .padding()
                        .glassEffect(.regular.tint(.orange).interactive())
                    
                    
                    // MARK: .clear
                    HStack {
                        Text(".clear")
                            .font(.title2)
                            .padding(.top, 32)
                        Spacer()
                    }
                    
                    Text(".glassEffect(.clear)")
                        .padding()
                        .glassEffect(.clear)
                    
                    Text(".glassEffect(.clear.interactive())")
                        .padding()
                        .glassEffect(.clear.interactive())
                    
                    Text(".glassEffect(.clear.interactive(), in: .rect)")
                        .padding()
                        .glassEffect(.clear.interactive(), in: .rect)
                    
                    Text(".glassEffect(.clear.tint(.green))")
                        .padding()
                        .glassEffect(.clear.tint(.yellow))
                    
                    Text(".glassEffect(.clear.tint(.green).interactive())")
                        .padding()
                        .glassEffect(.clear.tint(.yellow).interactive())
                    
                    // MARK: .identity
                    HStack {
                        Text(".identity")
                            .font(.title2)
                            .padding(.top, 32)
                        Spacer()
                    }
                    
                    Text(".glassEffect(.identity)")
                        .padding()
                        .glassEffect(.identity)
                    
                    Text(".glassEffect(.identity.interactive())")
                        .padding()
                        .glassEffect(.identity.interactive())
                    
                    Text(".glassEffect(.identity.interactive(), in: .rect))")
                        .padding()
                        .glassEffect(.identity.interactive(), in: .rect)
                }
                .padding()
            }
            .navigationTitle("glassEffect Examples")
            .background {
                Image(.sonoma)
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
    GlassEffectModifieriOS26()
}
