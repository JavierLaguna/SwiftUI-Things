
import Foundation

struct CreditCard: Identifiable, Equatable {
    let id = UUID()
    let image: String
    let movements: [CreditCardMovement]
    
    var namespaceId: String {
        "walletCard-\(image)"
    }
}

extension CreditCard {
    
    static let mockCards = [
        CreditCard(image: "creditCard1", movements: [Int](repeating: 1, count: Int.random(in: 1...12)).map { _ in
            CreditCardMovement.random()
        }),
        CreditCard(image: "creditCard2", movements: [Int](repeating: 1, count: Int.random(in: 1...20)).map { _ in
            CreditCardMovement.random()
        })
    ]
}
