import SwiftUI

extension DisplayLargeNumbersExample: NativeModifiersThing {
    static let title = "Display Large Numbers"
    static func makeView() -> some View { Self() }
}

struct DisplayLargeNumbersExample: View {
    
    var body: some View {
        VStack(spacing: 32) {
            Text(
                1000,
                format: .number.notation(.compactName)
            )
            
            Text(
                10000,
                format: .number.notation(.compactName)
            )
            
            Text(
                1000000,
                format: .number.notation(.compactName)
            )
        }
        .font(.largeTitle)
        .fontWeight(.black)
        .foregroundStyle(.colorPomegranateDark)
    }
}

#Preview {
    DisplayLargeNumbersExample()
}
