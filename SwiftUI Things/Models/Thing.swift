
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
            // MARK: SampleApp
            Thing(title: "Restart", destination: .restart, type: .sampleApp),
            Thing(title: "Pinch", destination: .pinch, type: .sampleApp),
            Thing(title: "Fructus", destination: .fructus, type: .sampleApp),
            Thing(title: "Connect 4", destination: .connect4, type: .sampleApp),
            Thing(title: "Wallet", destination: .wallet, type: .sampleApp)
        ]
    }
}
