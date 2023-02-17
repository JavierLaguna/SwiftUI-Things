
import SwiftUI

struct FructusContentView: View {
    
    @State private var isShowingSettings: Bool = false
    
    var fruits: [Fruit] = fruitsData
    
    var body: some View {
        List {
            ForEach(fruits.shuffled()) { item in
                NavigationLink(destination: FruitDetailView(fruit: item)) {
                    FruitRowView(fruit: item)
                        .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Fruits")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarItems(
            trailing:
                Button(action: {
                    isShowingSettings = true
                }) {
                    Image(systemName: "slider.horizontal.3")
                }
                .sheet(isPresented: $isShowingSettings) {
                    FructusSettingsView()
                }
        )
    }
}

// MARK: - PREVIEW
struct FructusContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            FructusContentView(fruits: fruitsData)
        }
        .previewDevice("iPhone 13")
    }
}
