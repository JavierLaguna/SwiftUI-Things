
import SwiftUI

enum C4PlayerType {
    case red
    case white
    
    var color: Color {
        switch self {
        case .red: return Color.red
        case .white: return Color.white
        }
    }
}
