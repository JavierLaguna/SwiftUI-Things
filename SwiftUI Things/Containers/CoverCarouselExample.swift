import SwiftUI

struct CoverCarouselExample: View {
    
    @State private var activeId: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomCarousel(
                    config: .init(
                        hasOpacity: false,
                        hasScale: true,
                        cardWidth: 200,
                        minimunCardWidth: 30
                    ),
                    selection: $activeId,
                    data: ImageModel.images
                ) { item in
                    Image(item.image)
                        .resizable()
                        .scaledToFill()
                }
                .frame(height: 180)
                
                Picker("", selection: .constant("")) {
                    Text("Complete")
                    Text("Opacity")
                    Text("Scale")
                    Text("Both")
                }
                .pickerStyle(.segmented)
                .padding(.top, 32)
                .padding(.horizontal, 24)
            }
            .navigationTitle("Cover Carousel")
        }
    }
}

private struct CustomCarousel<Content: View, Data: RandomAccessCollection>: View where Data.Element: Identifiable {
    
    var config: Config
    @Binding var selection: Data.Element.ID?
    var data: Data
    @ViewBuilder var content: (Data.Element) -> Content
    
    struct Config {
        var hasOpacity = false
        var opacityValue: CGFloat = 0.4
        var hasScale = false
        var scaleValue: CGFloat = 0.2
        
        var cardWidth: CGFloat = 150
        var spacing: CGFloat = 10
        var cornerRadius: CGFloat = 15
        var minimunCardWidth: CGFloat = 40
    }
    
    @ViewBuilder
    private func itemView(_ item: Data.Element) -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
            let progress = minX / (config.cardWidth + config.spacing)
            let minimunCardWidth = config.minimunCardWidth
            
            let diffWidth = config.cardWidth - minimunCardWidth
            let reducingWidth = progress * diffWidth
            let cappedWidth = min(reducingWidth, diffWidth)
            
            let resizedFrameWidth = size.width - (minX > 0 ? cappedWidth : min(-cappedWidth, diffWidth))
            let negativeProgress = max(-progress, 0)
            
            let scaleValue = config.scaleValue * abs(progress)
            let opacityValue = config.opacityValue * abs(progress)
            
            content(item)
                .frame(width: size.width, height: size.height)
                .frame(width: resizedFrameWidth)
                .opacity(config.hasOpacity ? 1 - opacityValue : 1)
                .scaleEffect(config.hasScale ? 1 - scaleValue : 1)
                .mask {
                    let hasScale = config.hasScale
                    let scaleHeight = (1 - scaleValue) * size.height
                    
                    RoundedRectangle(cornerRadius: config.cornerRadius)
                        .frame(height: hasScale ? max(scaleHeight, 0) : size.height)
                }
                .offset(x: -reducingWidth)
                .offset(x: min(progress, 1) * diffWidth)
                .offset(x: negativeProgress * diffWidth)
        }
        .frame(width: config.cardWidth)
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ScrollView(.horizontal) {
                HStack(spacing: config.spacing) {
                    ForEach(data) { item in
                        itemView(item)
                    }
                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal, max((size.width - config.cardWidth) / 2, 0))
            .scrollPosition(id: $selection)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .scrollIndicators(.hidden)
        }
    }
}

private struct ImageModel: Identifiable {
    var id: UUID = .init()
    var image: String
    
    static var images: [ImageModel] = (1...8).compactMap {
        .init(image: "Profile \($0)")
    }
}

#Preview {
    CoverCarouselExample()
}
