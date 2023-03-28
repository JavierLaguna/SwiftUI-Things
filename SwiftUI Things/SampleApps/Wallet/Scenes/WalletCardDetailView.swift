
import SwiftUI

struct WalletCardDetailView: View {
    
    private let card: CreditCard
    private let showDetailContent: Bool
    private var namespace: Namespace.ID
    private let unselectCard: () -> Void
    
    @State private var initScrollPosition: CGFloat = .zero
    @State private var showNavBackgroundColor = false
    @State private var showSmallCard = false
    
    init(card: CreditCard, showDetailContent: Bool, namespace: Namespace.ID, unselectCard: @escaping () -> Void) {
        self.card = card
        self.showDetailContent = showDetailContent
        self.namespace = namespace
        self.unselectCard = unselectCard
    }
    
    private func onChangeScrollPosition(position: CGFloat) {
        if !showNavBackgroundColor, position < initScrollPosition {
            withAnimation(.easeInOut) {
                showNavBackgroundColor = true
            }
        } else if showNavBackgroundColor, position >= initScrollPosition {
            withAnimation(.easeInOut) {
                showNavBackgroundColor = false
            }
        }
        
        if !showSmallCard, initScrollPosition - position >= 240 {
            withAnimation(.easeOut) {
                showSmallCard = true
            }
        } else if showSmallCard, initScrollPosition - position <= 230{
            withAnimation(.easeOut) {
                showSmallCard = false
            }
        }
    }
    
    @ViewBuilder
    private var navigationBar: some View {
        HStack {
            Button {
                unselectCard()
            } label: {
                Text("OK")
                    .matchedGeometryEffect(id: WalletConstants.NamespaceId.navTitleNameSpaceId, in: namespace, properties: .position)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            CreditCardView(cardName: card.image)
                .frame(height: 24)
                .opacity(showSmallCard ? 1 : 0)
                .offset(y: showSmallCard ? 0 : 14)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "ellipsis.circle")
                    .matchedGeometryEffect(id: WalletConstants.NamespaceId.navIconNameSpaceId, in: namespace)
                    .font(.title3)
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
        .background(.ultraThinMaterial.opacity(showNavBackgroundColor ? 1 : 0))
        .overlay(alignment: .bottom) {
            if showNavBackgroundColor {
                Divider()
            }
        }
    }
    
    @ViewBuilder
    private var movementsList: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Last movements")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack {
                ForEach(card.movements) { movement in
                    CardMovementCellView(movement: movement)
                    
                    if movement != card.movements.last {
                        Divider()
                            .padding(.leading, 14)
                    }
                }
            }
            .background(.white)
            .cornerRadius(12)
            .padding(.top, 4)
            .padding(.bottom, 20)
        }
        .padding(.top, 16)
        .padding(.horizontal)
        .opacity(showDetailContent ? 1 : 0)
        .background(GeometryReader {
            let position = $0.frame(in: .global).midY
            
            Color.clear.preference(key: ViewOffsetKey.self, value: position)
                .onAppear {
                    initScrollPosition = position
                }
        })
        .onPreferenceChange(ViewOffsetKey.self) {
            onChangeScrollPosition(position: $0)
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            CreditCardView(cardName: card.image)
                .matchedGeometryEffect(id: card.namespaceId, in: namespace)
                .onTapGesture {
                    unselectCard()
                }
                .padding(.top, 44)
                .padding(.horizontal)
                .shadow(radius: 12)
            
            movementsList
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("ColorAppleWallet").opacity(showDetailContent ? 1 : 0))
        .transition(.opacity)
        .overlay(alignment: .top) {
            navigationBar
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct WalletCardDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        @Namespace var namespace
        
        WalletCardDetailView(
            card: CreditCard.mockCards.first!,
            showDetailContent: true,
            namespace: namespace
        ) {
            
        }
    }
}
