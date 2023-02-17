
import SwiftUI

struct FructusOnboardingView: View {
    
    var fruits: [Fruit] = fruitsData
    
    var body: some View {
        TabView {
            ForEach(fruits[0...5]) { item in
                FruitCardView(fruit: item)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical, 20)
    }
}

// MARK: - PREVIEW
struct FructusOnboardingView_Previews: PreviewProvider {
    
    static var previews: some View {
        FructusOnboardingView(fruits: fruitsData)
            .previewDevice("iPhone 13")
    }
}
