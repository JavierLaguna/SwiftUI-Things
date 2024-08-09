import SwiftUI

struct ListSectionSpacingExample: View {
    
    private let options: [ListSectionSpacing] = [
        .default,
        .compact,
        .custom(70)
    ]
    
    @State var spacing: ListSectionSpacing = .default
    
    var body: some View {
        VStack {
            List {
                Section {
                    Text("iPhone 15")
                    Text("iPhone 15 Pro")
                    Text("iPhone 15 Pro Max")
                }
                
                Section {
                    Text("MacBook Air")
                    Text("MacBook Pro")
                }
            }
            .listSectionSpacing(spacing)
            
            Button("Change") {
                spacing = options.randomElement() ?? .default
            }
            .buttonStyle(.borderedProminent)
            
            Text("Current spacing:")
            Text("\(spacing)")
        }
    }
}

#Preview {
    ListSectionSpacingExample()
}
