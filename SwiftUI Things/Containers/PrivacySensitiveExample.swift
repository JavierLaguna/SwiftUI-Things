
import SwiftUI

struct PrivacySensitiveExample: View {
    
    @State private var hideContent = true
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "key.fill")
                
                Toggle("Privacy Sensitive", isOn: $hideContent)
            }
            .font(.title)
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.title3)
                .privacySensitive(hideContent)
                .redacted(reason: .privacy)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    PrivacySensitiveExample()
}
