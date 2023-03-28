
import SwiftUI

struct CardMovementCellView: View {
    
    private let movement: CreditCardMovement
    
    init(movement: CreditCardMovement) {
        self.movement = movement
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(movement.shop)
                    .font(.body)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("\(String(format: "%.2f", movement.value)) €")
                    .font(.subheadline)
                
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 4)
            }
            
            Text(movement.city)
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text(movement.date)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .background(.white)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
    }
}

struct CardMovementCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardMovementCellView(movement: CreditCardMovement.random())
            .previewLayout(.sizeThatFits)
            .background(Color("ColorAppleWallet"))
    }
}
