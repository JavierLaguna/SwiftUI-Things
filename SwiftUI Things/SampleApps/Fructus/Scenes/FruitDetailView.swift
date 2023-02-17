
import SwiftUI

struct FruitDetailView: View {
    
    var fruit: Fruit
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                
                FruitHeaderView(fruit: fruit)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(fruit.title)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(fruit.gradientColors[1])
                    
                    Text(fruit.headline)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                    
                    FruitNutrientsView(fruit: fruit)
                    
                    Text("Learn more about \(fruit.title)".uppercased())
                        .fontWeight(.bold)
                        .foregroundColor(fruit.gradientColors[1])
                    
                    Text(fruit.description)
                        .multilineTextAlignment(.leading)
                    
                    SourceLinkView()
                        .padding(.top, 10)
                        .padding(.bottom, 40)
                    
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: 640, alignment: .center)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(StackNavigationViewStyle())
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - PREVIEW
struct FruitDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            FruitDetailView(fruit: fruitsData[0])
        }
        .previewDevice("iPhone 13")
    }
}
