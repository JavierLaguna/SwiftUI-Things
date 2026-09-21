import SwiftUI

extension GaugeStylesExample: NativeComponentThing {
    static let title = "Gauge Styles"
    static func makeView() -> some View { Self() }
}

struct GaugeStylesExample: View {
    // Gauge value. Starts at 65% as a representative middle value.
    @State private var value = 65.0

    var body: some View {
        // A ScrollView so all styles remain visible on smaller screens.
        ScrollView {
            VStack(spacing: 20) {
                // Descriptive headline for the example.
                Text("In iOS 16+, use Gauge to show a value within a range, then choose from different built-in styles with gaugeStyle().")
                    .font(.headline)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                // --- Style: .linearCapacity ---
                VStack(alignment: .leading, spacing: 5) {
                    Text(".linearCapacity").font(.caption).foregroundColor(.secondary)
                    gaugeComponent
                        .gaugeStyle(.linearCapacity)
                }

                Divider()

                // --- Style: .accessoryLinear ---
                VStack(alignment: .leading, spacing: 5) {
                    Text(".accessoryLinear").font(.caption).foregroundColor(.secondary)
                    gaugeComponent
                        .gaugeStyle(.accessoryLinear)
                }

                Divider()

                // --- Style: .accessoryLinearCapacity ---
                VStack(alignment: .leading, spacing: 5) {
                    Text(".accessoryLinearCapacity").font(.caption).foregroundColor(.secondary)
                    gaugeComponent
                        .gaugeStyle(.accessoryLinearCapacity)
                }

                Divider()

                // --- Style: .accessoryCircular ---
                VStack(spacing: 5) {
                    Text(".accessoryCircular").font(.caption).foregroundColor(.secondary)
                    gaugeComponent
                        .gaugeStyle(.accessoryCircular)
                        .frame(width: 80, height: 80) // Circular styles sometimes need an explicit frame
                }

                Divider()

                // --- Style: .accessoryCircularCapacity ---
                VStack(spacing: 5) {
                    Text(".accessoryCircularCapacity").font(.caption).foregroundColor(.secondary)
                    gaugeComponent
                        .gaugeStyle(.accessoryCircularCapacity)
                        .frame(width: 80, height: 80) // Circular styles sometimes need an explicit frame
                }

                Spacer(minLength: 50)

                // An optional slider to change the value in real time and see the update.
                Slider(value: $value, in: 0...100, step: 1)
                    .padding(.horizontal)
                Text("Adjust Value: \(Int(value))%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle("Gauge Styles")
    }

    // A ViewBuilder that creates the base Gauge component reused by every style.
    @ViewBuilder
    private var gaugeComponent: some View {
        Gauge(value: value, in: 0...100) {
            Text("Level")
        } currentValueLabel: {
            Text("\(Int(value))%")
        }
        // Note: the `.gaugeStyle(...)` modifier is applied per instance above.
    }
}

#Preview {
    NavigationStack {
        GaugeStylesExample()
    }
}