import SwiftUI

extension DateFormatExample: NativeModifiersThing {
    static let title = "Date format"
    static func makeView() -> some View { Self() }
}

struct DateFormatExample: View {
    
    var body: some View {
        List {
            Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 100000000), thresholdField: .year))
            
            Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 10000000), thresholdField: .year))
            
            Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 1000000), thresholdField: .year))
            
            Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 100000), thresholdField: .year))
            
            Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 10000), thresholdField: .year))
            
            Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 1000), thresholdField: .year))
            
            Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 10), thresholdField: .year))
            
            Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 0), thresholdField: .second))
        }
    }
}

#Preview {
    DateFormatExample()
}
