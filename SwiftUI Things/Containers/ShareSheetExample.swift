
import SwiftUI

struct ShareSheetExample: View {
    
    private func shareButton() {
        let url = URL(string: "https://developer.apple.com/xcode/swiftui/")
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
    
    var body: some View {
        Button(action: shareButton) {
            Image(systemName: "square.and.arrow.up")
                .foregroundColor(.black)
        }
    }
}

struct ShareSheetExample_Previews: PreviewProvider {
    
    static var previews: some View {
        ShareSheetExample()
    }
}
