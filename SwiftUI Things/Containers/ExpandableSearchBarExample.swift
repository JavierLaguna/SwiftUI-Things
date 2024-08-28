import SwiftUI

struct ExpandableSearchBarExample: View {
    
    @State private var searchText = ""
    @State private var progress: CGFloat = 0
    @FocusState private var isFocused: Bool
    
    nonisolated private func offsetY(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
        
        return minY > 0 ? (isFocused ? -minY : 0) : -minY
    }
    
    @ViewBuilder
    private func resizableHeader() -> some View {
        let progress = isFocused ? 1 : progress
        
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome Back!")
                        .font(.callout)
                        .foregroundStyle(.gray)
                    
                    Text("iJustine")
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Image("Profile 4")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(.circle)
                }
            }
            .frame(height: 60 - (60 * progress), alignment: .bottom)
            .padding(.horizontal, 15)
            .padding(.top, 15)
            .padding(.bottom, 15 - (15 * progress))
            .opacity(1 - progress)
            .offset(y: -10 * progress)
            
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                
                TextField("Search Photos", text: $searchText)
                    .focused($isFocused)
                
                Button {
                    
                } label: {
                    Image(systemName: "mic.fill")
                        .foregroundStyle(.red)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 15)
            .background {
                RoundedRectangle(cornerRadius: isFocused ? 0 : 30)
                    .fill(.background
                        .shadow(.drop(color: .black.opacity(0.08), radius: 5, x: 5, y: 5))
                        .shadow(.drop(color: .black.opacity(0.05), radius: 5, x: -5, y: -5))
                    )
                    .padding(.top, isFocused ? -100 : 0)
            }
            .padding(.horizontal, isFocused ? 0 : 15)
            .padding(.bottom, 10)
            .padding(.top, 5)
        }
        .background {
            ProgressiveBlurView()
                .blur(radius: isFocused ? 0 : 10)
                .padding(.horizontal, -15)
                .padding(.bottom, -10)
                .padding(.top, -100)
        }
        .visualEffect { content, proxy in
            content
                .offset(y: offsetY(proxy))
        }
    }
    
    @ViewBuilder
    private func cardView(_ item: Item) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            GeometryReader {
                let size = $0.size
                
                if let url = URL(string: item.image) {
                    AsyncImage(
                        url: url,
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(.rect(cornerRadius: 20))
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
            }
            .frame(height: 220)
            
            Text("By: \(item.title)")
                .font(.callout)
                .foregroundStyle(.primary.secondary)
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                ForEach(Item.sample) { item in
                    cardView(item)
                }
            }
            .padding(15)
            .offset(y: isFocused ? 0 : progress * 75)
            .padding(.bottom, 75)
            .safeAreaInset(edge: .top, spacing: 0) {
                resizableHeader()
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(CustomScrollTarget())
        .animation(.snappy(duration: 0.3, extraBounce: 0), value: isFocused)
        .onScrollGeometryChange(for: CGFloat.self) {
            $0.contentOffset.y + $0.contentInsets.top
            
        } action: { oldValue, newValue in
            progress = max(min(newValue / 75, 1), 0)
        }
    }
}

private struct ProgressiveBlurView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> CustomBlurView {
        let view = CustomBlurView()
        view.backgroundColor = .clear
        return view
    }
    
    func updateUIView(_ uiView: CustomBlurView, context: Context) {
        // Empty
    }
}

private final class CustomBlurView: UIVisualEffectView {
    
    init() {
        super.init(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        removeFilters()
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, _) in
            DispatchQueue.main.async {
                self.removeFilters()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func removeFilters() {
        if let filterLayer = layer.sublayers?.first {
            filterLayer.filters = []
        }
    }
}

private struct CustomScrollTarget: ScrollTargetBehavior {
    
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        let endPoint = target.rect.minY
        
        if endPoint < 75 {
            if endPoint > 40 {
                target.rect.origin = .init(x: 0, y: 75)
            } else {
                target.rect.origin = .zero
            }
        }
    }
}

private struct Item: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var image: String
    
    static let sample: [Item] = [
        Item(title: "Han-Chieh Lee", image: "https://images.pexels.com/photos/20672997/pexels-photo-20672997/free-photo-of-black-butterfly-on-red-flower.jpeg"),
        Item(title: "新宇E", image: "https://images.pexels.com/photos/18970192/pexels-photo-18970192/free-photo-of-river-and-lake-behind.jpeg"),
        Item(title: "Abril Altamirano", image: "https://images.pexels.com/photos/18873058/pexels-photo-18873058/free-photo-of-hot-air-balloons-flying-in-cappadocia-at-sunrise.jpeg"),
        Item(title: "Gülsah Aydogan", image: "https://images.pexels.com/photos/8001019/pexels-photo-8001019/free-photo-of-winter-landscape-with-wooden-cottage-in-snowy-forest.jpeg"),
        Item(title: "Melike Sayar Melikesayar", image: "https://images.pexels.com/photos/8058776/pexels-photo-8058776/free-photo-of-branches-with-green-leaves-in-nature.jpeg"),
        Item(title: "Maahid Photos", image: "https://images.pexels.com/photos/7945985/pexels-photo-7945985/free-photo-of-bush-with-green-fern-leaves.jpeg"),
        Item(title: "Pelageia Zelenina", image: "https://images.pexels.com/photos/7939089/pexels-photo-7939089/free-photo-of-tree-growing-among-agricultural-field-in-countryside.jpeg"),
        Item(title: "Ofir Eliav", image: "https://images.pexels.com/photos/8001169/pexels-photo-8001169/free-photo-of-scenic-landscape-of-autumn-forest-with-tall-trees-in-fog.jpeg"),
        Item(title: "Melike Sayar Melikesayar", image: "https://images.pexels.com/photos/8000995/pexels-photo-8000995/free-photo-of-old-city-with-illuminated-buildings-and-roads-at-night.jpeg"),
        Item(title: "Melike Sayar Melikesayar", image: "https://images.pexels.com/photos/7724075/pexels-photo-7724075/free-photo-of-shore-with-dried-grass-near-river.jpeg"),
        Item(title: "Erik Mclean", image: "https://images.pexels.com/photos/9387799/pexels-photo-9387799/free-photo-of-person-hand-with-bouquet-of-flowers-on-narrow-footbridge.jpeg"),
        Item(title: "Fatma DELIASLAN", image: "https://images.pexels.com/photos/22555211/pexels-photo-22555211/free-photo-of-a-river-runs-through-a-valley-in-the-mountains.jpeg"),
        Item(title: "Varun Tyagi", image: "https://images.pexels.com/photos/22555211/pexels-photo-22555211/free-photo-of-a-river-runs-through-a-valley-in-the-mountains.jpeg"),
        Item(title: "新宇 王", image: "https://images.pexels.com/photos/18970192/pexels-photo-18970192/free-photo-of-river-and-lake-behind.jpeg"),
        Item(title: "Abril Altamirano", image: "https://images.pexels.com/photos/18873058/pexels-photo-18873058/free-photo-of-hot-air-balloons-flying-in-cappadocia-at-sunrise.jpeg"),
        Item(title: "Gülsah Aydogan", image: "https://images.pexels.com/photos/8001019/pexels-photo-8001019/free-photo-of-winter-landscape-with-wooden-cottage-in-snowy-forest.jpeg"),
        Item(title: "Melike Sayar Melikesayar", image: "https://images.pexels.com/photos/8058776/pexels-photo-8058776/free-photo-of-branches-with-green-leaves-in-nature.jpeg")
    ]
}

#Preview {
    ExpandableSearchBarExample()
}
