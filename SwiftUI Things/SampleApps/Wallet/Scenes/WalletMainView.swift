
import SwiftUI

struct WalletMainView: View {
    
    private let cards = CreditCard.mockCards
    
    @Namespace private var namespace
    
    @State private var selectedCard: CreditCard?
    @State private var showDetailContent = false
    
    private func selectCard(_ card: CreditCard) {
        withAnimation(.spring()) {
            selectedCard = card
            showDetailContent = true
        }
    }
    
    private func unselectCard() {
        withAnimation(.spring()) {
            showDetailContent = false
        }
        
        withAnimation(.spring().delay(0.05)) {
            selectedCard = nil
        }
    }
    
    @ViewBuilder
    private var navigationBar: some View {
        HStack {
            Text("Wallet")
                .matchedGeometryEffect(id: WalletConstants.NamespaceId.navTitleNameSpaceId, in: namespace, properties: .position)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            Group {
                Button {
                    // Nothing
                } label: {
                    Image(systemName: "shippingbox.circle.fill")
                        .opacity(selectedCard != nil ? 0 : 1)
                }
                
                Button {
                    // Nothing
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .matchedGeometryEffect(id: WalletConstants.NamespaceId.navIconNameSpaceId, in: namespace)
                }
            }
            .font(.title)
            .foregroundColor(.black)
        }
    }
    
    @ViewBuilder
    private var cardsList: some View {
        VStack(spacing: 15) {
            ForEach(cards) { card in
                CreditCardView(cardName: card.image)
                    .matchedGeometryEffect(id: card.namespaceId, in: namespace)
                    .offset(y: card == cards.first ? 0 : -190)
                    .onTapGesture {
                        selectCard(card)
                    }
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                if !showDetailContent {
                    navigationBar
                    
                    cardsList
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 44)
            .padding(.horizontal, 16)
            .background(Color("ColorAppleWallet"))
            
            if let selectedCard {
                WalletCardDetailView(
                    card: selectedCard,
                    showDetailContent: showDetailContent,
                    namespace: namespace,
                    unselectCard: unselectCard
                )
            }
        }
    }
}

struct WalletMainView_Previews: PreviewProvider {
    
    static var previews: some View {
        WalletMainView()
    }
}
