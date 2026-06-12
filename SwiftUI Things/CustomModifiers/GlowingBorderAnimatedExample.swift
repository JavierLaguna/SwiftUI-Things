// Credits: Kavsoft
// https://www.youtube.com/watch?v=DHqLSjgBNPY

import SwiftUI

extension GlowingBorderAnimatedExample: CustomModifiersThing {
    static let title = "GlowingBorderAnimated"
    static func makeView() -> some View { Self() }
}

struct GlowingBorderAnimatedExample: View {
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 24) {
                TextField("Ask Anything...", text: .constant(""))
                    .padding(.top, 8)
                
                HStack(spacing: 20) {
                    Button {
                        
                    } label: {
                        Text("Name/Model Name")
                            .font(.caption)
                            .foregroundStyle(.primary.opacity(0.8))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(.fill, in: .capsule)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Group {
                        Button {
                            
                        } label: {
                            Image(systemName: "plue")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "cloud")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "mic")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.up")
                                .frame(width: 34, height: 34)
                                .background(.background, in: .circle)
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
            .padding(16)
            .borderBeam(
                border: .primary,
                hideFadeBorder: false,
                beam: [.green, .blue, .pink, .orange, .indigo],
                beamBlur: 15,
                cornerRadius: 20,
                isEnabled: true
            )
            .background(
                .gray.opacity(0.1),
                in: .rect(cornerRadius: 20)
            )
            
        }
        .padding()
    }
}

extension View {
    
    @ViewBuilder
    func borderBeam(
        border: Color,
        hideFadeBorder: Bool = true,
        beam: [Color],
        beamBlur: CGFloat,
        cornerRadius: CGFloat,
        isEnabled: Bool = true
    ) -> some View {
        self.modifier(
            BorderBeamEffect(
                border: border,
                hideFadeBorder: hideFadeBorder,
                beam: beam,
                beamBlur: beamBlur,
                cornerRadius: cornerRadius,
                isEnabled: isEnabled
            )
        )
    }
}

struct BorderBeamEffect: ViewModifier {
    
    var border: Color
    var hideFadeBorder: Bool
    var beam: [Color]
    var beamBlur: CGFloat
    var cornerRadius: CGFloat
    var isEnabled: Bool
    
    @ViewBuilder
    private func BorderBeamView() -> some View {
        ZStack {
            if !hideFadeBorder {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(border.tertiary, lineWidth: 0.6)
            }
            
            KeyframeAnimator(initialValue: 0.0, repeating: true) { value in
                let rotation = value * 360
                let borderGradient = AngularGradient(
                    colors: [.clear, border, .clear],
                    center: .center,
                    startAngle: .degrees(140 + rotation),
                    endAngle: .degrees(270 + rotation)
                )
                
                // Beam Gradient
                let beamGradient = LinearGradient(
                    colors: beam,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(beamGradient)
                    .mask {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .overlay {
                                Rectangle()
                                    .blur(radius: beamBlur)
                                    .blendMode(.destinationOut)
                            }
                    }
                    .mask {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(borderGradient)
                            .blur(radius: beamBlur / 1.5)
                            .padding(-beamBlur * 2)
                    }
                
                
                // Border Gradient
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderGradient, lineWidth: 0.6)
                
            } keyframes: { _ in
                LinearKeyframe(1, duration: 2.5)
            }
        }
        .padding(0.5)
    }
    
    func body(content: Content) -> some View {
        content
            .background {
                if isEnabled {
                    BorderBeamView()
                }
            }
    }
}

#Preview {
    GlowingBorderAnimatedExample()
}
