import SwiftUI

struct TabBarExampleiOS26Wrapper: View {
    
    var body: some View {
        if #available(iOS 26.0, *) {
            TabBarExampleiOS26()
        } else {
            Text("iOS 26 device required")
        }
    }
}

@available(iOS 26.0, *)
struct TabBarExampleiOS26: View {
    
    enum MinimizeBehavior: String, CaseIterable {
        case auto
        case onScrollDown
        case onScrollUp
        case never
        
        @available(iOS 26.0, *)
        var behavior: TabBarMinimizeBehavior {
            switch self {
            case .auto: .automatic
            case .onScrollDown: .onScrollDown
            case .onScrollUp: .onScrollUp
            case .never: .never
            }
        }
    }
    
    @Environment(\.tabViewBottomAccessoryPlacement) private var tabViewBottomAccessoryPlacement
    @State private var searchText = ""
    @State private var selectedOption: MinimizeBehavior = .onScrollDown
    
    var body: some View {
        TabView {
            Tab("People", systemImage: "person") {
                VStack {
                    Text("tabBarMinimizeBehavior")
                        .font(.title)
                    
                    Picker("tabBarMinimizeBehavior", selection: $selectedOption) {
                        ForEach(MinimizeBehavior.allCases, id: \.self) { item in
                            Text("\(item.rawValue)").tag(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    List {
                        ForEach(1...50, id: \.self) { index in
                            Text("Item \(index)")
                        }
                    }
                }
            }
            
            Tab("Planets", systemImage: "globe") {
                Text("Planets Screen")
            }
            
            Tab(role: .search) {
                NavigationStack {
                    VStack {
                        Text("Search screen")
                        Text(searchText)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search...")
        .tabBarMinimizeBehavior(selectedOption.behavior)
        .tabViewBottomAccessory {
            HStack {
                VStack(alignment: .leading) {
                    Text("tabViewBottomAccessory")
                        .font(.caption)
                    
                    Text(String(describing: tabViewBottomAccessoryPlacement))
                        .font(.caption2)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "play")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "stop")
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    TabBarExampleiOS26Wrapper()
}
