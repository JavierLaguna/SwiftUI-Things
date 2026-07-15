import SwiftUI
import iOS26Macros

extension DisplayLargeNumbersExample: NativeModifiersThing {
    static let title = "Display Large Numbers"
    static func makeView() -> some View { Self() }
}

struct DisplayLargeNumbersExample: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
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
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "Uses .number.notation(.compactName) to display large numbers in abbreviated form — 1K, 10K, 1M — with heavy black typography in pomegranate color.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    DisplayLargeNumbersExample()
}
