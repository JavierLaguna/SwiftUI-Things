
enum ThingType {
    case iOS26
    case component
    case container
    case sampleApp
    
    var title: String {
        switch self {
        case .iOS26: "iOS 26"
        case .component: "Component"
        case .container: "Container"
        case .sampleApp:"Sample App"
        }
    }
}
