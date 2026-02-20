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
protocol SampleAppThing: Thing {}

enum ThingSection: String, CaseIterable, Identifiable {
    case ios26 = "iOS 26 Liquid Glass"
    case customComponents = "Custom Components"
    case nativeComponents = "Native Components"
    case customModifiers = "Custom Modifiers"
    case nativeModifiers = "Modifiers"
    case sampleApps = "Sample Apps"

    var id: String { rawValue }
}

enum ThingRegistry {
    
    static let bySection: [ThingSection: [AnyThing]] = [
        .ios26: [
            AnyThing(CustomAnimatedToolBariOS26.self),
            AnyThing(GlassEffectModifieriOS26.self),
            AnyThing(ToolbariOS26.self),
            AnyThing(GlassEffectContainerExampleiOS26.self),
            AnyThing(TabBarExampleiOS26Wrapper.self),
            AnyThing(CustomMenuiOS26.self),
        ],
        .customComponents: [
            AnyThing(SlideToSandbox.self),
            AnyThing(CircleGroupViewSandbox.self),
            AnyThing(BackgroundMotionAnimationView.self),
            AnyThing(LoadingView.self),
            AnyThing(GradientText.self),
            AnyThing(MorphingSymbolViewExample.self),
            AnyThing(ExpandableCustomSliderExample.self),
            AnyThing(CompositionalGridLayoutExample.self),
            AnyThing(DropdownViewExample.self),
            AnyThing(CoverCarouselExample.self),
            AnyThing(ExpandableSearchBarExample.self),
            AnyThing(DragNDropWithScrollExample.self),
            AnyThing(ScrollViewAnimationEffect.self),
            AnyThing(AnimatedDialogs.self),
            AnyThing(SwiftUIViewToPDF.self),
        ],
        .nativeComponents: [
            AnyThing(ViewThatFitsExample.self),
            AnyThing(ViewThatFitsScrollExample.self),
            AnyThing(LinkView.self),
            AnyThing(ShareSheetExample.self),
            AnyThing(UnevenRoundedRectangleExample.self),
            AnyThing(MapExample.self),
            AnyThing(MeshGradientExample.self),
            AnyThing(MarkdownExample.self),
            AnyThing(ImageAndTextExample.self),
            AnyThing(PhotosPickerStylesExample.self),
            AnyThing(FloatingTabBarExample.self),
            AnyThing(MenuWithSectionsExample.self),
            AnyThing(NestedMenusExample.self),
            AnyThing(RenameButtonExample.self),
            AnyThing(DeviceInformationExample.self),
            AnyThing(GaugeExample.self),
            AnyThing(GroupBoxExample.self),
        ],
        .customModifiers: [
            AnyThing(StretchyVisualEffect.self),
            AnyThing(AdaptedTextColorExample.self),
            AnyThing(FloatingBottomSheetExample.self),
        ],
        .nativeModifiers: [
            AnyThing(LongPressGestureExample.self),
            AnyThing(AnimationModifierAndTimingExample.self),
            AnyThing(TransformAnimationsExample.self),
            AnyThing(TapAnimationExample.self),
            AnyThing(MatchedGeometryEffectExample.self),
            AnyThing(AdvancedMatchedGeometryEffectExample.self),
            AnyThing(PopoverExample.self),
            AnyThing(RedactedPlaceholderExample.self),
            AnyThing(HorizontalScrollWithRotate3DEffectExample.self),
            AnyThing(ActionSheetExample.self),
            AnyThing(MaskingExample.self),
            AnyThing(InvertedMaskingExample.self),
            AnyThing(ListSectionSpacingExample.self),
            AnyThing(BadgeExample.self),
            AnyThing(DisplayArrayUserFriendlyExample.self),
            AnyThing(DateFormatExample.self),
            AnyThing(MixColorsExample.self),
            AnyThing(ReserveTextSpaceExample.self),
            AnyThing(ButtonBorderShapesExample.self),
            AnyThing(ButtonBorderAnimatedExample.self),
            AnyThing(PrivacySensitiveExample.self),
            AnyThing(InspectorExample.self),
            AnyThing(DetectTapLocationExample.self),
            AnyThing(RotateGestureExample.self),
            AnyThing(TextSelectionExample.self),
            AnyThing(TimerExample.self),
            AnyThing(GlowingGradientBorder.self),
            AnyThing(SwipeActionsLabelStyleExample.self),
        ],
        .sampleApps: [
            AnyThing(RestartMainView.self),
            AnyThing(PinchMainView.self),
            AnyThing(FructusApp.self),
            AnyThing(C4GameView.self),
            AnyThing(WalletSandbox.self),
            AnyThing(PSIntroView.self),
            AnyThing(AnimatedPaywallExample.self),
            AnyThing(AppWideOverlays.self),
        ],
    ]
}
