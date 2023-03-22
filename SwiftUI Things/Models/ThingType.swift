
enum ThingType {
    case component
    case container
    case sampleApp
    
    var title: String {
        switch self {
        case .component:
            return "Component"
        case .container:
            return "Container"
        case .sampleApp:
            return "Sample App"
        }
    }
}
