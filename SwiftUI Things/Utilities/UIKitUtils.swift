
import UIKit

struct UIKitUtils {
    
    static var rootViewController: UIViewController? {
        UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }?.rootViewController
    }
}
