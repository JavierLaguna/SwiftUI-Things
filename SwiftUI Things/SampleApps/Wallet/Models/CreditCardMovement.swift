
import Foundation

struct CreditCardMovement: Identifiable, Equatable {
    let id = UUID()
    let shop: String
    let value: Double
    let city: String
    let date: String
}

extension CreditCardMovement {

   static func random() -> CreditCardMovement {
        let shops = ["Apple Store", "Parking", "Circo Pizza", "FNAC", "Starbucks"]
        let cities = ["Madrid, Madrid", "Sillicon Valley, California", "New York, New York", "Barcelona, Barcelona"]
        let dates = ["Hace 15 minutos", "Hoy", "Ayer", "Miércoles", "Viernes", "13/03/23"]
        
        return CreditCardMovement(
            shop: shops.randomElement()!,
            value: Double.random(in: 1...2000),
            city: cities.randomElement()!,
            date: dates.randomElement()!
        )
    }
}
