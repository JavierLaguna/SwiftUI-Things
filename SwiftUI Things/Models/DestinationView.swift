
import SwiftUI

enum DestinationView {
    // MARK: Component
    case slideTo
    case circleGroup
    case backgroundMotionAnimation
    // MARK: Container
    case longPressGestureExample
    case animationModifierAndTimingExample
    case transformAnimationsExample
    case tapAnimationExample
    case matchedGeometryEffectExample
    case popoverExample
    // MARK: SampleApp
    case restart
    case pinch
    case fructus
    case connect4
}

extension DestinationView {
    
    @ViewBuilder
    func getView() -> some View {
        switch self {
            // MARK: Component
        case .slideTo: SlideToSandbox()
        case .circleGroup: CircleGroupViewSandbox()
        case .backgroundMotionAnimation: BackgroundMotionAnimationView()
            // MARK: Container
        case .longPressGestureExample: LongPressGestureExample()
        case .animationModifierAndTimingExample: AnimationModifierAndTimingExample()
        case .transformAnimationsExample: TransformAnimationsExample()
        case .tapAnimationExample: TapAnimationExample()
        case .matchedGeometryEffectExample: MatchedGeometryEffectExample()
        case .popoverExample: PopoverExample()
            // MARK: SampleApp
        case .restart: RestartMainView()
        case .pinch: PinchMainView()
        case .fructus: FructusApp()
        case .connect4: C4GameView()
        }
    }
}
