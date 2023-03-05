
import SwiftUI

enum DestinationView {
    case slideTo
    case circleGroup
    case backgroundMotionAnimation
    case restart
    case pinch
    case fructus
    case connect4
}

extension DestinationView {
    
    @ViewBuilder
    func getView() -> some View {
        switch self {
        case .slideTo: SlideToSandbox()
        case .circleGroup: CircleGroupViewSandbox()
        case .backgroundMotionAnimation: BackgroundMotionAnimationView()
        case .restart: RestartMainView()
        case .pinch: PinchMainView()
        case .fructus: FructusApp()
        case .connect4: C4GameView()
        }
    }
}
