
import Foundation

struct Thing: Identifiable {
    let id = UUID()
    let title: String
    let destination: DestinationView
    let type: ThingType
}

extension Array where Element == Thing {
    
    func getByType() -> [(ThingType, [Thing])] {
        return [
            (.component, self.filter { $0.type == .component }),
            (.container, self.filter { $0.type == .container }),
            (.sampleApp, self.filter { $0.type == .sampleApp })
        ]
    }
}

extension Thing {
    
    static func allThings() -> [Thing] {
        return [
            // MARK: Component
            Thing(title: "Slide To", destination: .slideTo, type: .component),
            Thing(title: "Circle Group", destination: .circleGroup, type: .component),
            Thing(title: "Background Motion Animation", destination: .backgroundMotionAnimation, type: .component),
            Thing(title: "Loading", destination: .loading, type: .component),
            Thing(title: "Link", destination: .link, type: .component),
            Thing(title: "Gradient Text", destination: .gradientText, type: .component),
            Thing(title: "Morphing Symbol", destination: .morphingSymbol, type: .component),
            
            // MARK: Container
            Thing(title: "Long Press Gesture", destination: .longPressGestureExample, type: .container),
            Thing(title: "Animation Modifier and Timing", destination: .animationModifierAndTimingExample, type: .container),
            Thing(title: "Transform Animations", destination: .transformAnimationsExample, type: .container),
            Thing(title: "Tap Animation", destination: .tapAnimationExample, type: .container),
            Thing(title: "Matched Geometry Effect", destination: .matchedGeometryEffectExample, type: .container),
            Thing(title: "Popover", destination: .popoverExample, type: .container),
            Thing(title: "Advanced Matched Geometry Effect", destination: .advancedMatchedGeometryEffectExample, type: .container),
            Thing(title: "Redacted Placeholder", destination: .redactedPlaceholderExample, type: .container),
            Thing(title: "Horizontal Scroll Rotate 3D Effect", destination: .horizontalScrollWithRotate3DEffectExample, type: .container),
            Thing(title: "Share Sheet", destination: .shareSheetExample, type: .container),
            Thing(title: "Action Sheet", destination: .actionSheetExample, type: .container),
            Thing(title: "ViewThatFits", destination: .viewThatFitsExample, type: .container),
            Thing(title: "ViewThatFits Scroll", destination: .viewThatFitsScrollExample, type: .container),
            Thing(title: "Adapted Text Color", destination: .adaptedTextColor, type: .container),
            Thing(title: "Masking", destination: .masking, type: .container),
            Thing(title: "Inverted Masking", destination: .invertedMasking, type: .container),
            Thing(title: "List Section Spacing", destination: .listSectionSpacing, type: .container),
            Thing(title: "Badges", destination: .badge, type: .container),
            Thing(title: "UnevenRoundedRectangle", destination: .unevenRoundedRectangle, type: .container),
            Thing(title: "Map", destination: .map, type: .container),
            Thing(title: "Display array user friendly", destination: .displayArrayUserFriendly, type: .container),
            Thing(title: "Date Format", destination: .dateFormat, type: .container),
            Thing(title: "Mix Colors", destination: .mixColors, type: .container),
            Thing(title: "Mesh Gradient", destination: .meshGradient, type: .container),
            Thing(title: "Compositional Grid Layout", destination: .compositionalGridLayout, type: .container),
            Thing(title: "Floating Bottom Sheet", destination: .floatingBottomSheet, type: .container),
            Thing(title: "Reserve Text Space", destination: .reserveTextSpace, type: .container),
            Thing(title: "Button Border Shapes", destination: .buttonBorderShapes, type: .container),
            Thing(title: "Markdown text", destination: .markdown, type: .container),
            Thing(title: "Privacy sensitive text", destination: .privacySensitive, type: .container),
            Thing(title: "Image and Text", destination: .imageAndText, type: .container),
            Thing(title: "Photos Picker Styles", destination: .photosPickerStyles, type: .container),
            Thing(title: "Floating Tab Bar", destination: .floatingTabBar, type: .container),
            Thing(title: "Dropdown", destination: .dropdownView, type: .container),
            
            // MARK: SampleApp
            Thing(title: "Restart", destination: .restart, type: .sampleApp),
            Thing(title: "Pinch", destination: .pinch, type: .sampleApp),
            Thing(title: "Fructus", destination: .fructus, type: .sampleApp),
            Thing(title: "Connect 4", destination: .connect4, type: .sampleApp),
            Thing(title: "Wallet", destination: .wallet, type: .sampleApp),
            Thing(title: "PS Intro", destination: .psIntro, type: .sampleApp),
        ]
    }
}
