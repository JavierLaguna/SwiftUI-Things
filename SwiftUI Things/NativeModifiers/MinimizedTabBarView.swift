import SwiftUI

extension MinimizedTabBarView: NativeModifiersThing {
    static let title = "Minimized TabBar"
    static func makeView() -> some View { Self() }
}

struct MinimizedTabBarView: View {
    
    var body: some View {
        TabView {
            // Explore Tab
            NavigationStack {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(1...10, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.orange)
                                .frame(height: 150)
                                .overlay(
                                    Text("Destination \(index)")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                )
                        }
                    }
                    .padding()
                }
            }
            .tabItem {
                Label("Explore", systemImage: "safari")
            }
            
            // Saved Tab
            Text("Saved Content")
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            
            // Profile Tab
            Text("Profile Content")
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
        // Modificador de la imagen que minimiza el TabBar al hacer scroll
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    MinimizedTabBarView()
}
