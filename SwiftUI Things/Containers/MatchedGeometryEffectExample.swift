
import SwiftUI

/***
 It is not recommended to use Matched Geometry Effect on containers like
 VStack, HStack and ZStack. Instead, you should use it on elements like shapes, texts and buttons.
 */
struct MatchedGeometryEffectExample: View {
    
    private struct Page: Identifiable {
        let id = UUID()
        let title: String
        let imageName: String
    }
    
    private let pages = [
        Page(title: "Front", imageName: "magazine-front-cover"),
        Page(title: "Back", imageName: "magazine-back-cover")
    ]
    
    @Namespace private var namespace
    @State private var selectedPage: Page?
    
    private func titleMGEId(_ page: Page) -> String {
        "title \(page.title)"
    }
    
    private func imageMGEId(_ page: Page) -> String {
        "image \(page.title)"
    }
    
    private func changeSelectedPage(page: Page?) {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            selectedPage = page
        }
    }
    
    var body: some View {
        ZStack {
            if let selectedPage {
                VStack() {
                    Text(selectedPage.title)
                        .font(.title)
                        .underline()
                        .padding()
                        .matchedGeometryEffect(id: titleMGEId(selectedPage), in: namespace)
                    
                    Image(selectedPage.imageName)
                        .resizable()
                        .scaledToFill()
                        .matchedGeometryEffect(id: imageMGEId(selectedPage), in: namespace)
                }
                .frame(maxWidth: .infinity, maxHeight: 400)
                .onTapGesture {
                    changeSelectedPage(page: nil)
                }
                
            } else {
                ScrollView {
                    HStack {
                        ForEach(pages) { page in
                            Image(page.imageName)
                                .resizable()
                                .scaledToFill()
                                .matchedGeometryEffect(id: imageMGEId(page), in: namespace)
                                .frame(width: 100, height: 100)
                                .overlay(alignment: .bottom) {
                                    Text(page.title)
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                        .padding(4)
                                        .background(.ultraThinMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                        .matchedGeometryEffect(id: titleMGEId(page), in: namespace)
                                }
                                .onTapGesture {
                                    changeSelectedPage(page: page)
                                }
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 8)
                }
            }
        }
    }
}

struct MatchedGeometryEffectExample_Previews: PreviewProvider {
    
    static var previews: some View {
        MatchedGeometryEffectExample()
    }
}
