
import SwiftUI

enum DestinationView {
    // MARK: Component
    case slideTo
    case circleGroup
    case backgroundMotionAnimation
    case loading
    case link
    case gradientText
    
    // MARK: Container
    case longPressGestureExample
    case animationModifierAndTimingExample
    case transformAnimationsExample
    case tapAnimationExample
    case matchedGeometryEffectExample
    case popoverExample
    case advancedMatchedGeometryEffectExample
    case redactedPlaceholderExample
    case horizontalScrollWithRotate3DEffectExample
    case shareSheetExample
    case actionSheetExample
    case viewThatFitsExample
    case viewThatFitsScrollExample
    case adaptedTextColor
    case masking
    case invertedMasking
    case listSectionSpacing
    case badge
    case unevenRoundedRectangle
    case map
    case displayArrayUserFriendly
    case dateFormat
    case mixColors
    case meshGradient
    
    // MARK: SampleApp
    case restart
    case pinch
    case fructus
    case connect4
    case wallet
}

extension DestinationView {
    
    @ViewBuilder
    func getView() -> some View {
        switch self {
            // MARK: Component
        case .slideTo: SlideToSandbox()
        case .circleGroup: CircleGroupViewSandbox()
        case .backgroundMotionAnimation: BackgroundMotionAnimationView()
        case .loading: LoadingView()
        case .link: LinkView()
        case .gradientText: GradientText()
            
            // MARK: Container
        case .longPressGestureExample: LongPressGestureExample()
        case .animationModifierAndTimingExample: AnimationModifierAndTimingExample()
        case .transformAnimationsExample: TransformAnimationsExample()
        case .tapAnimationExample: TapAnimationExample()
        case .matchedGeometryEffectExample: MatchedGeometryEffectExample()
        case .popoverExample: PopoverExample()
        case .advancedMatchedGeometryEffectExample: AdvancedMatchedGeometryEffectExample()
        case .redactedPlaceholderExample: RedactedPlaceholderExample()
        case .horizontalScrollWithRotate3DEffectExample: HorizontalScrollWithRotate3DEffectExample()
        case .shareSheetExample: ShareSheetExample()
        case .actionSheetExample: ActionSheetExample()
        case .viewThatFitsExample: ViewThatFitsExample()
        case .viewThatFitsScrollExample: ViewThatFitsScrollExample(count: 220)
        case .adaptedTextColor: AdaptedTextColorExample()
        case .masking: MaskingExample()
        case .invertedMasking: InvertedMaskingExample()
        case .listSectionSpacing: ListSectionSpacingExample()
        case .badge: BadgeExample()
        case .unevenRoundedRectangle: UnevenRoundedRectangleExample()
        case .map: MapExample()
        case .displayArrayUserFriendly: DisplayArrayUserFriendlyExample()
        case .dateFormat: DateFormatExample()
        case .mixColors: MixColorsExample()
        case .meshGradient: MeshGradientExample()
            
            // MARK: SampleApp
        case .restart: RestartMainView()
        case .pinch: PinchMainView()
        case .fructus: FructusApp()
        case .connect4: C4GameView()
        case .wallet: WalletSandbox()
        }
    }
}
