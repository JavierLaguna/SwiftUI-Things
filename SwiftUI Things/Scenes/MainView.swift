import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ThingSection.allCases) { section in
                    let items = ThingRegistry.bySection[section, default: []]
                    if !items.isEmpty {
                        Section(section.rawValue) {
                            ForEach(items) { item in
                                NavigationLink(destination: item.view) {
                                    Text(item.title)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(" SwiftUI Things!")
        }
    }
}


#Preview {
    MainView()
}
