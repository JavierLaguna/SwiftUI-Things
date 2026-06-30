import SwiftUI

struct MainView: View {
    
    @State private var searchText = ""
    @State private var selectedCategory: ThingSection? = nil
    
    private var filteredSections: [(ThingSection, [AnyThing])] {
        let sectionsToEvaluate: [ThingSection]
        if let selectedCategory {
            sectionsToEvaluate = [selectedCategory]
        } else {
            sectionsToEvaluate = ThingSection.allCases
        }
        
        return sectionsToEvaluate.compactMap { section in
            let allItems = ThingRegistry.bySection[section, default: []]
            guard !allItems.isEmpty else { return nil }
            
            guard !searchText.isEmpty else {
                return (section, allItems)
            }
            
            let matchingItems = allItems.filter { item in
                item.title.localizedCaseInsensitiveContains(searchText)
                || section.rawValue.localizedCaseInsensitiveContains(searchText)
            }
            return matchingItems.isEmpty ? nil : (section, matchingItems)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                categoryPicker
                
                if filteredSections.isEmpty && (!searchText.isEmpty || selectedCategory != nil) {
                    ContentUnavailableView(
                        "No Results",
                        systemImage: "magnifyingglass",
                        description: Text("Try a different search or category")
                    )
                } else {
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
                }
            }
            .navigationTitle(" SwiftUI Things!")
            .searchable(text: $searchText, prompt: "Search by name or category")
        }
    }
    
    private var categoryPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ChipButton(
                    title: "All",
                    isSelected: selectedCategory == nil
                ) {
                    selectedCategory = nil
                }
                
                ForEach(ThingSection.allCases) { section in
                    ChipButton(
                        title: section.rawValue,
                        isSelected: selectedCategory == section
                    ) {
                        selectedCategory = section
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(.bar)
    }
}

private struct ChipButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.accentColor : Color(.systemGray6))
                .foregroundStyle(isSelected ? .white : .primary)
                .clipShape(.capsule)
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    MainView()
}
