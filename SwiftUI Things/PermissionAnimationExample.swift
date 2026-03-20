// Credits: Kavsoft
// https://www.youtube.com/watch?v=iCTAr3E4_fA

import SwiftUI

struct PermissionAnimationExample: View {
    
    var body: some View {
        PermissionOnBoarding(
            config: .init(
                iPhoneTint: .gray,
                buttonTint: .black,
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
        var title: String
        var description: String
        var alertButtons: Buttons
        var activeTap: ActiveTap
        var primaryTitle: String
        var primaryAction: () -> ()
        var secondaryTitle: String?
        var secondaryAction: (() -> ())?
    }
    
    var config: Config
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(.clear)
            
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
                
                
            }
            .frame(height: 220)
        }
    }
}

#Preview {
    PermissionAnimationExample()
}
