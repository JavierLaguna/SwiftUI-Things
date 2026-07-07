import SwiftUI

protocol Thing {
    associatedtype FeatureView: View
    static var title: String { get }
    @ViewBuilder static func makeView() -> FeatureView
}

struct AnyThing: Identifiable {
    let id = UUID()
    let title: String
    let view: AnyView

    init<F: Thing>(_ type: F.Type) {
        title = F.title
        view = AnyView(F.makeView())
    }
}

protocol IOS26Thing: Thing {}
protocol CustomComponentThing: Thing {}
protocol NativeComponentThing: Thing {}
protocol CustomModifiersThing: Thing {}
protocol NativeModifiersThing: Thing {}
protocol NativeEnvironmentThing: Thing {}
protocol SampleAppThing: Thing {}

enum ThingSection: String, CaseIterable, Identifiable {
    case ios26 = "iOS 26 Liquid Glass"
    case customComponents = "Custom Components"
    case nativeComponents = "Native Components"
    case customModifiers = "Custom Modifiers"
    case nativeModifiers = "Native Modifiers"
    case nativeEnvironment = "Native Environment"
    case sampleApps = "Sample Apps"

    var id: String { rawValue }
}

enum ThingRegistry {
    
    static let bySection: [ThingSection: [AnyThing]] = [
        .ios26: [
            AnyThing(CustomAnimatedToolBariOS26.self),
            AnyThing(CustomMenuiOS26.self),
            AnyThing(GlassEffectContainerExampleiOS26.self),
            AnyThing(GlassEffectModifieriOS26.self),
            AnyThing(TabBarExampleiOS26Wrapper.self),
            AnyThing(ToolbariOS26.self),
        ],
        .customComponents: [
            AnyThing(AnimatedDialogs.self),
            AnyThing(BackgroundMotionAnimationView.self),
            AnyThing(CircleGroupViewSandbox.self),
            AnyThing(CompositionalGridLayoutExample.self),
            AnyThing(CoverCarouselExample.self),
            AnyThing(DragNDropWithScrollExample.self),
            AnyThing(DropdownViewExample.self),
            AnyThing(ExpandableCustomSliderExample.self),
            AnyThing(ExpandableSearchBarExample.self),
            AnyThing(FloatingTabBarExample.self),
            AnyThing(GradientText.self),
            AnyThing(LoadingView.self),
            AnyThing(MorphingSymbolViewExample.self),
            AnyThing(ScrollViewAnimationEffect.self),
            AnyThing(SlideToSandbox.self),
            AnyThing(SwiftUIViewToPDF.self),
            AnyThing(TagStatusExample.self),
            AnyThing(ToolbarHeaderScrollAnimationExample.self),
        ],
        .nativeComponents: [
            AnyThing(CountDownExample.self),
            AnyThing(DeviceInformationExample.self),
            AnyThing(GaugeExample.self),
            AnyThing(GroupBoxExample.self),
            AnyThing(ImageAndTextExample.self),
            AnyThing(LinkView.self),
            AnyThing(MapExample.self),
            AnyThing(MarkdownExample.self),
            AnyThing(MenuWithSectionsExample.self),
            AnyThing(MeshGradientExample.self),
            AnyThing(NestedMenusExample.self),
            AnyThing(PhotosPickerStylesExample.self),
            AnyThing(RenameButtonExample.self),
            AnyThing(ShareSheetExample.self),
            AnyThing(UnevenRoundedRectangleExample.self),
            AnyThing(ViewThatFitsExample.self),
            AnyThing(ViewThatFitsScrollExample.self),
        ],
        .customModifiers: [
            AnyThing(AdaptedTextColorExample.self),
            AnyThing(FloatingBottomSheetExample.self),
            AnyThing(GlowingBorderAnimatedExample.self),
            AnyThing(StretchyVisualEffect.self),
        ],
        .nativeModifiers: [
            AnyThing(ActionSheetExample.self),
            AnyThing(AdvancedMatchedGeometryEffectExample.self),
            AnyThing(AnimationModifierAndTimingExample.self),
            AnyThing(BadgeExample.self),
            AnyThing(BlurTextExample.self),
            AnyThing(ButtonBorderAnimatedExample.self),
            AnyThing(ButtonBorderShapesExample.self),
            AnyThing(DateFormatExample.self),
            AnyThing(DefaultScrollAnchorExample.self),
            AnyThing(DetectTapLocationExample.self),
            AnyThing(DisplayArrayUserFriendlyExample.self),
            AnyThing(DisplayLargeNumbersExample.self),
            AnyThing(GlowingGradientBorder.self),
            AnyThing(HorizontalScrollWithRotate3DEffectExample.self),
            AnyThing(InspectorExample.self),
            AnyThing(InvertedMaskingExample.self),
            AnyThing(ListLetterIndexExample.self),
            AnyThing(ListSectionSpacingExample.self),
            AnyThing(LongPressGestureExample.self),
            AnyThing(MaskingExample.self),
            AnyThing(MatchedGeometryEffectExample.self),
            AnyThing(MixColorsExample.self),
            AnyThing(PopoverExample.self),
            AnyThing(PrivacySensitiveExample.self),
            AnyThing(RedactedPlaceholderExample.self),
            AnyThing(ReserveTextSpaceExample.self),
            AnyThing(RotateGestureExample.self),
            AnyThing(SwipeActionsLabelStyleExample.self),
            AnyThing(TapAnimationExample.self),
            AnyThing(TextSelectionExample.self),
            AnyThing(TimerExample.self),
            AnyThing(TransformAnimationsExample.self),
        ],
        .nativeEnvironment: [
            AnyThing(DetermineLightDarkModeExample.self),
        ],
        .sampleApps: [
            AnyThing(AnimatedPaywallExample.self),
            AnyThing(AppWideOverlays.self),
            AnyThing(C4GameView.self),
            AnyThing(CalendarAppExample.self),
            AnyThing(FructusApp.self),
            AnyThing(PermissionAnimationExample.self),
            AnyThing(PinchMainView.self),
            AnyThing(PSIntroView.self),
            AnyThing(RestartMainView.self),
            AnyThing(WalletSandbox.self),
        ],
    ]
}
