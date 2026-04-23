// Credits: Kavsoft
// https://www.youtube.com/watch?v=iCTAr3E4_fA

import SwiftUI

extension PermissionAnimationExample: SampleAppThing {
    static let title = "Permission animation"
    static func makeView() -> some View { Self() }
}

struct PermissionAnimationExample: View {
    
    var body: some View {
        PermissionOnBoarding(
            config: .init(
                iPhoneTint: .gray,
                buttonTint: .blue,
                initialDelay: 0.5,
                title: "Stay Connected with\nPush Notifications",
                description: "We will send you push notifications to keep\nyoy updated on the latest news and updates.",
                alertButtons: .two,
                activeTap: .one,
                primaryTitle: "Continue",
                primaryAction: {
                    
                },
                secondaryTitle: "Ask me Later",
                secondaryAction: {
                    
                }
            )
        )
    }
}

private struct PermissionOnBoarding: View {
    
    enum Buttons: Int, CaseIterable {
        case two = 2
        case three = 3
    }
    
    enum ActiveTap: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
    
    struct Config {
        var iPhoneTint: Color = .gray
        var buttonTint: Color = .blue
        var initialDelay: CGFloat = 0
        var title: String
        var description: String
        var alertButtons: Buttons
        var activeTap: ActiveTap
        var primaryTitle: String
        var primaryAction: () -> ()
        var secondaryTitle: String?
        var secondaryAction: (() -> ())?
    }
    
    @Animatable
    struct Frame {
        var opacity: CGFloat = 0
        var scale: CGFloat = 1.1
        var tapOpacity: CGFloat = 0
        var tapScale: CGFloat = 1
    }
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var showPermissionsAnimation = false
    
    var config: Config
    
    var foreground: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var background: Color {
        colorScheme != .dark ? .white : .black
    }
    
    @ViewBuilder
    private func iPhoneView() -> some View {
        Rectangle()
            .foregroundStyle(.clear)
            .overlay(alignment: .top) {
                let cornerRadius: CGFloat = 55
                let fill: Color = Color.primary.opacity(0.15)
                
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(fill)
                        .overlay(alignment: .top) {
                            // Status Bar
                            HStack(spacing: 12) {
                                Text("9:41")
                                
                                Spacer(minLength: 0)
                                
                                Image(systemName: "wifi")
                                
                                Image(systemName: "battery.50percent")
                            }
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .frame(height: 37)
                            .padding(.horizontal, 30)
                            .offset(y: 20)
                        }
                        .overlay(alignment: .top) {
                            // Dynamic Island
                            Capsule()
                                .fill(.black)
                                .frame(width: 120, height: 37)
                                .offset(y: 20)
                        }
                    
                    // Bezel
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius + 7)
                            .stroke(config.iPhoneTint, lineWidth: 10)
                        
                        RoundedRectangle(cornerRadius: cornerRadius + 7)
                            .stroke(.black, lineWidth: 4)
                        
                        RoundedRectangle(cornerRadius: cornerRadius + 7)
                            .stroke(.black, lineWidth: 6)
                            .padding(4)
                    }
                    .padding(-7)
                    
                    // Permission Popup
                    if showPermissionsAnimation {
                        AnimatedAlertView()
                    }
                }
                .frame(width: 402, height: 874)
            }
            .visualEffect{ content, proxy in
                let designSize = CGSize(width: 402, height: 874)
                let currentSize = proxy.size
                let ratioX = currentSize.width / designSize.width
                let ratioY = currentSize.height / designSize.height
                let ratio = min(ratioX, ratioY)
                
                return content
                    .scaleEffect(ratio, anchor: .top)
            }
            .padding(.top, 10)
            .padding(.bottom, 220)
            .frame(maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    private func AnimatedAlertView() -> some View {
        let fill = Color.primary.opacity(0.15)
        
        KeyframeAnimator(initialValue: Frame(), repeating: true) { frame in
            VStack(alignment: .leading, spacing: 6) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(fill)
                    .frame(width: 120, height: 20)
                    .padding(.bottom, 12)
                
                RoundedRectangle(cornerRadius: 3)
                    .fill(fill)
                    .frame(height: 15)
                
                RoundedRectangle(cornerRadius: 3)
                    .fill(fill)
                    .frame(height: 15)
                    .padding(.trailing, 50)
                    .padding(.bottom, 30)
                
                // Buttons
                let layout = config.alertButtons == .three ? AnyLayout(VStackLayout(spacing: 8)) : AnyLayout(HStackLayout(spacing: 8))
                
                layout {
                    ForEach(1...config.alertButtons.rawValue, id: \.self) { index in
                        Capsule()
                            .fill(fill)
                            .frame(height: 45)
                            .overlay {
                                if config.activeTap.rawValue == index {
                                    Circle()
                                        .fill(.gray.opacity(0.8))
                                        .padding(5)
                                        .opacity(frame.tapOpacity)
                                }
                            }
                            .scaleEffect(config.activeTap.rawValue == index ? frame.tapScale : 1)
                    }
                }
            }
            .frame(width: 300)
            .padding(config.alertButtons == .two ? 15 : 20)
            .optionalLiquidGlass()
            .opacity(frame.opacity)
            .scaleEffect(frame.scale)
            
        } keyframes: { _ in
            SpringKeyframe(
                Frame(opacity: 1, scale: 1),
                duration: 0.7,
                spring: .smooth(duration: 0.5, extraBounce: 0)
            )
            
            SpringKeyframe(
                Frame(opacity: 1, scale: 1, tapOpacity: 1),
                duration: 0.1,
                spring: .smooth(duration: 0.4, extraBounce: 0)
            )
            
            SpringKeyframe(
                Frame(opacity: 1, scale: 1, tapOpacity: 1, tapScale: 0.9),
                duration: 0.2,
                spring: .smooth(duration: 0.4, extraBounce: 0)
            )
            
            SpringKeyframe(
                Frame(opacity: 1, scale: 1),
                duration: 0.4,
                spring: .smooth(duration: 0.4, extraBounce: 0)
            )
            
            SpringKeyframe(
                Frame(),
                duration: 2,
                spring: .smooth(duration: 0.4, extraBounce: 0)
            )
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            iPhoneView()
            
            // View Content
            VStack(spacing: 16) {
                Text(config.title)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                Text(config.description)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.bottom, 10)
                
                Button {
                    
                } label: {
                    Text(config.primaryTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(config.buttonTint)
                .frame(height: 45)
                .frame(maxWidth: 300)
                
                if let secondaryTitle = config.secondaryTitle,
                   let secondaryAction = config.secondaryAction {
                    Button {
                        secondaryAction()
                    } label: {
                        Text(secondaryTitle)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .frame(height: 220)
            .padding(16)
            .frame(maxWidth: .infinity)
            .background {
                Rectangle()
                    .fill(background)
                    .blur(radius: 25)
                    .padding(-60)
                    .ignoresSafeArea()
            }
        }
        .padding(.top, 20)
        .task {
            guard !showPermissionsAnimation else { return }
            try? await Task.sleep(for: .seconds(config.initialDelay))
            showPermissionsAnimation = true
        }
    }
}

extension View {
    
    @ViewBuilder
    func optionalLiquidGlass() -> some View {
        if #available(iOS 26, *) {
            self
                .glassEffect(.clear, in: .rect(cornerRadius: 30))
            
        } else {
            self
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.background)
                        
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.gray.opacity(0.4), lineWidth: 1)
                    }
                }
        }
    }
}

#Preview {
    PermissionAnimationExample()
}
