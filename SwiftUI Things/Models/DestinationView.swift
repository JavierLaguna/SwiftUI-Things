
import SwiftUI

enum DestinationView {
    // MARK: Component
    case slideTo
    case circleGroup
    case backgroundMotionAnimation
    case loading
    case link
    case gradientText
    case morphingSymbol
    case expandableCustomSlider
    
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
    case compositionalGridLayout
    case floatingBottomSheet
    case reserveTextSpace
    case buttonBorderShapes
    case buttonBorderAnimated
    case markdown
    case privacySensitive
    case imageAndText
    case photosPickerStyles
    case floatingTabBar
    case dropdownView
    case menuWithSections
    case nestedMenus
    case inspector
    case detectTapLocation
    case renameButton
    case rotateGesture
    case deviceInformation
    case gauge
    case textSelection
    case coverCarousel
    case expandableSearchBar
    case groupBox
    case dragNDropWithScroll
    case timer
    case scrollViewAnimationEffect
    case appWideOverlays
    case glowingGradientBorder
    
    // MARK: SampleApp
    case restart
    case pinch
    case fructus
    case connect4
    case wallet
    case psIntro
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
        case .morphingSymbol: MorphingSymbolViewExample()
        case .expandableCustomSlider: ExpandableCustomSliderExample()
            
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
        case .compositionalGridLayout: CompositionalGridLayoutExample()
        case .floatingBottomSheet: FloatingBottomSheetExample()
        case .reserveTextSpace: ReserveTextSpaceExample()
        case .buttonBorderShapes: ButtonBorderShapesExample()
        case .buttonBorderAnimated: ButtonBorderAnimatedExample()
        case .markdown: MarkdownExample()
        case .privacySensitive: PrivacySensitiveExample()
        case .imageAndText: ImageAndTextExample()
        case .photosPickerStyles: PhotosPickerStylesExample()
        case .floatingTabBar: FloatingTabBarExample()
        case .dropdownView: DropdownViewExample()
        case .menuWithSections: MenuWithSectionsExample()
        case .nestedMenus: NestedMenusExample()
        case .inspector: InspectorExample()
        case .detectTapLocation: DetectTapLocationExample()
        case .renameButton: RenameButtonExample()
        case .rotateGesture: RotateGestureExample()
        case .deviceInformation: DeviceInformationExample()
        case .gauge: GaugeExample()
        case .textSelection: TextSelectionExample()
        case .coverCarousel: CoverCarouselExample()
        case .expandableSearchBar: ExpandableSearchBarExample()
        case .groupBox: GroupBoxExample()
        case .dragNDropWithScroll: DragNDropWithScrollExample()
        case .timer: TimerExample()
        case .scrollViewAnimationEffect: ScrollViewAnimationEffect()
        case .appWideOverlays: AppWideOverlays()
        case .glowingGradientBorder: GlowingGradientBorder()
            
            // MARK: SampleApp
        case .restart: RestartMainView()
        case .pinch: PinchMainView()
        case .fructus: FructusApp()
        case .connect4: C4GameView()
        case .wallet: WalletSandbox()
        case .psIntro: PSIntroView()
        }
    }
}
