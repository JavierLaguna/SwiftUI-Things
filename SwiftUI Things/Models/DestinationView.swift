
import SwiftUI

enum DestinationView {
    case slideTo
    case circleGroup
    case restart
    case pinch
    case fructus
}

extension DestinationView {
    
    @ViewBuilder
    func getView() -> some View {
        switch self {
        case .slideTo: SlideToSandbox()
        case .circleGroup: CircleGroupViewSandbox()
        case .restart: RestartMainView()
        case .pinch: PinchMainView()
        case .fructus: FructusApp()
        }
    }
}
