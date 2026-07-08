import SwiftUI
import iOS26Macros

extension FloatingTabBarExample: CustomComponentThing {
    static let title = "Floating TabBar"
    static func makeView() -> some View { Self() }
}

struct FloatingTabBarExample: View {

    @State private var activeTab: TabModel = .home

    var body: some View {
        let (preview, code) = #CodeSnippet(
            ZStack(alignment: .bottom) {
                Group {
                    TabView(selection: $activeTab) {
                        Tab.init(value: .home) {
                            HomeView()
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }

                        Tab.init(value: .search) {
                            Text("Search")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }

                        Tab.init(value: .notification) {
                            Text("Notifications")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }

                        Tab.init(value: .settings) {
                            Text("Settings")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                    }
                }

                CustomTabBar(activeTab: $activeTab)
            }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Custom Component", icon: "rectangle.3.group"),
            ],
            description: "A floating tab bar that overlays the content with animated capsule transitions and a morphing action button.",
            code: code,
            preview: { preview }
        )
    }
}

private struct HomeView: View {

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    ForEach(1...50, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.background)
                            .frame(height: 50)
                    }
                }
                .padding(15)
            }
            .navigationTitle("Floating Tab Bar")
            .background(Color.primary.opacity(0.07))
            .safeAreaPadding(.bottom, 60)
        }
    }
}

private struct CustomTabBar: View {

    var activeForeground: Color = .white
    var activeBackground: Color = .blue
    @Binding var activeTab: TabModel

    @Namespace private var animation
    @State private var tabLocation: CGRect = .zero

    var body: some View {
        let status = activeTab == .home || activeTab == .search

        HStack(spacing: !status ? 0 : 12) {
            HStack(spacing: 0) {
                ForEach(TabModel.allCases, id: \.rawValue) { tab in
                    Button {
                        activeTab = tab

                    } label: {
                        HStack(spacing: 0) {
                            Image(systemName: tab.rawValue)
                                .font(.title3.bold())
                                .frame(width: 30, height: 30)

                            if activeTab == tab {
                                Text(tab.title)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                            }
                        }
                        .foregroundStyle(activeTab == tab ? activeForeground : .gray)
                        .padding(.vertical, 2)
                        .padding(.leading, 10)
                        .padding(.trailing, 15)
                        .containerShape(.rect)
                        .background {
                            if activeTab == tab {
                                Capsule()
                                    .fill(.clear)
                                    .onGeometryChange(for: CGRect.self, of: {
                                        $0.frame(in: .named("TABBARVIEW"))
                                    }, action: { newValue in
                                        tabLocation = newValue
                                    })
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .background(alignment: .leading) {
                Capsule()
                    .fill(activeBackground.gradient)
                    .frame(width: tabLocation.width, height: tabLocation.height)
                    .offset(x: tabLocation.minX)
            }
            .coordinateSpace(.named("TABBARVIEW"))
            .padding(.horizontal, 5)
            .frame(height: 45)
            .background(
                .background
                    .shadow(.drop(color: .black.opacity(0.08), radius: 5, x: 5, y: 5))
                    .shadow(.drop(color: .black.opacity(0.06), radius: 5, x: -5, y: -5)),
                in: .capsule
            )
            .zIndex(10)

            Button {
                if activeTab == .home {
                    print("Profile")
                } else {
                    print("Microphone Search")
                }

            } label: {
                MorphingSymbolView(
                    symbol: activeTab == .home ? "person.fill" : "mic.fill",
                    config: .init(
                        font: .title3,
                        frame: .init(width: 42, height: 42),
                        radius: 2,
                        foregroundColor: activeForeground,
                        keyFrameDuration: 0.3,
                        symbolAnimation: .smooth(duration: 0.3, extraBounce: 0)
                    )
                )
                .background(activeBackground.gradient)
                .clipShape(.circle)
            }
            .allowsHitTesting(status)
            .offset(x: status ? 0 : -20)
            .padding(.leading, status ? 0 : -42)
        }
        .padding(.bottom, 5)
        .animation(.smooth(duration: 0.3, extraBounce: 0), value: activeTab)
    }
}

private enum TabModel: String, CaseIterable {
    case home = "house"
    case search = "magnifyingglass"
    case notification = "bell"
    case settings = "gearshape"

    var title: String {
        switch self {
        case .home: "Home"
        case .search: "Search"
        case .notification: "Notifications"
        case .settings: "Settings"
        }
    }
}

#Preview {
    FloatingTabBarExample()
}
