import SwiftUI
import iOS26Macros

extension GaugeExample: NativeComponentThing {
    static let title = "Gauge"
    static func makeView() -> some View { Self() }
}

struct GaugeExample: View {

    @State private var value = 0.5

    var body: some View {
        let (preview, code) = #CodeSnippet(
            VStack {
                Gauge(value: value) {
                    Image(systemName: "fuelpump.fill")
                        .foregroundStyle(value < 0.3 ? .orange : .green)
                        .font(.headline)
                        .symbolEffect(.bounce, value: value < 0.3 ? value : 0.0)

                } currentValueLabel: {
                    Text(value, format: .percent.precision(.fractionLength(1)))
                        .contentTransition(.numericText())
                        .transaction {
                            $0.animation = .default
                        }
                }
                .gaugeStyle(.accessoryCircular)
                .tint(.red)
                .scaleEffect(4.0)

                Slider(value: $value) {
                    // Empty
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("100")
                }
                .padding(.top, 120)
                .padding(.horizontal, 24)
            }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Component", icon: "square.3.layers.3d"),
            ],
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    GaugeExample()
}
