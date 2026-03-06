import SwiftUI

extension ListLetterIndexExample: NativeModifiersThing {
    static let title = "List Letter Index"
    static func makeView() -> some View { Self() }
}

struct ListLetterIndexExample: View {
    
    var body: some View {
        if #available(iOS 26.0, *) {
            List {
                ForEach(["A", "B", "C", "D", "E", "F"], id: \.self) { letter in
                    Section {
                        ForEach(1...5, id: \.self) {
                            Text("Item \($0)")
                        }
                    } header: {
                        Text("Section \(letter)")
                    }
                    .sectionIndexLabel(letter)
                }
            }
            .listSectionIndexVisibility(.visible)
            
        } else {
            Text("iOS 26 device required")
        }
    }
}

#Preview {
    ListLetterIndexExample()
}
