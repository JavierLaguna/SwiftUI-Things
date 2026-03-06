import SwiftUI

struct ScrollToTopDisable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            if let scrollView = view.superview?.superview?.subviews.last?.subviews.first as? UIScrollView {
                scrollView.scrollsToTop = false
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Empty
    }
}
