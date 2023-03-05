
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
            // MARK: Container
            Thing(title: "Long Press Gesture", destination: .longPressGestureExample, type: .container),
            Thing(title: "Animation Modifier and Timing", destination: .animationModifierAndTimingExample, type: .container),
            // MARK: SampleApp
            Thing(title: "Restart", destination: .restart, type: .sampleApp),
            Thing(title: "Pinch", destination: .pinch, type: .sampleApp),
            Thing(title: "Fructus", destination: .fructus, type: .sampleApp),
            Thing(title: "Connect 4", destination: .connect4, type: .sampleApp)
        ]
    }
}
