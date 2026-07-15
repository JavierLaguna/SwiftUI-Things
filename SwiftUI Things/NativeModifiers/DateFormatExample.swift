import SwiftUI
import iOS26Macros

extension DateFormatExample: NativeModifiersThing {
    static let title = "Date format"
    static func makeView() -> some View { Self() }
}

struct DateFormatExample: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            VStack(alignment: .leading) {
                Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 100000000), thresholdField: .year))

                Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 10000000), thresholdField: .year))

                Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 1000000), thresholdField: .year))

                Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 100000), thresholdField: .year))

                Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 10000), thresholdField: .year))

                Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 1000), thresholdField: .year))

                Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 10), thresholdField: .year))

                Text(Date.now, format: .reference(to: Date(timeIntervalSinceNow: 0), thresholdField: .second))
            }
            .padding()
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "A list of relative date references using Text with .reference(format:thresholdField:). Each row compares Date.now to a reference offset, showing how the threshold determines relative vs. absolute display.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    DateFormatExample()
}
