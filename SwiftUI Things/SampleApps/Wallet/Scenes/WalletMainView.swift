
import SwiftUI

struct WalletMainView: View {
    
    @Namespace private var namespace
    
    @State private var showDetail = false
    @State private var showDetailContent = false
    
    @ViewBuilder
    func CardView(imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
    }
    
    var body: some View {
        VStack(spacing: 15) {
            CardView(imageName: "creditCard1")
                
            if !showDetail {
                
                CardView(imageName: "creditCard2")
                    .matchedGeometryEffect(id: "CARD", in: namespace)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 4)) {
                            showDetail = true
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .background(.white)
        .navigationTitle("Wallet")
        .overlay(alignment: .top) {
            if showDetail {
                VStack(spacing: 15) {
        
                    
                    CardView(imageName: "creditCard2")
                        .matchedGeometryEffect(id: "CARD", in: namespace)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 4)) {
                                showDetailContent = false
                            }
                            
                            withAnimation(.easeInOut(duration: 4).delay(0.05)) {
                                showDetail = false
                            }
                        }
                    
                    VStack {
                        // TODO: Detail content
                    }
                    .opacity(showDetailContent ? 1 : 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()
                .background(.white.opacity(showDetailContent ? 1 : 0))
                .transition(.offset(x: 1, y: 1)) // HACK
                .onAppear() {
                    withAnimation(.easeInOut(duration: 4)) {
                        showDetailContent = true
                    }
                }
            }
        }
    }
}

struct WalletMainView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            WalletMainView()
        }
    }
}
