
import SwiftUI

struct CreditCardView: View {
    
    private let cardName: String
    
    init(cardName: String) {
        self.cardName = cardName
    }
    
    var body: some View {
        Image(cardName)
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    CreditCardView(cardName: "creditCard1")
        .previewLayout(.sizeThatFits)
        .padding()
}
