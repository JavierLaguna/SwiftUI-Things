import SwiftUI

struct MainView: View {
    
    @State private var searchText = ""
    
    private var filteredSections: [(ThingSection, [AnyThing])] {
        ThingSection.allCases.compactMap { section in
            let items = ThingRegistry.bySection[section, default: []]
            
            guard !searchText.isEmpty else {
                return items.isEmpty ? nil : (section, items)
            }
            
            let matchingItems = items.filter { item in
                item.title.localizedCaseInsensitiveContains(searchText)
                || section.rawValue.localizedCaseInsensitiveContains(searchText)
            }
            return matchingItems.isEmpty ? nil : (section, matchingItems)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredSections, id: \.0) { section, items in
                    Section(section.rawValue) {
                        ForEach(items) { item in
                            NavigationLink(destination: item.view) {
                                Text(item.title)
                            }
                        }
                    }
                }
            }
            .navigationTitle(" SwiftUI Things!")
            .searchable(text: $searchText, prompt: "Search by name or category")
        }
    }
}


#Preview {
    MainView()
}
