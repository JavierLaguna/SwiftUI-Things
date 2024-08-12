import SwiftUI

enum PsPage: String, CaseIterable {
    
    case page1 = "playstation.logo"
    case page2 = "gamecontroller.fill"
    case page3 = "link.icloud.fill"
    case page4 = "text.bubble.fill"
    
    var title: String {
        switch self {
        case .page1: "Welcome to PlayStation"
        case .page2: "DualSense wireless controller"
        case .page3: "PlayStation remote play"
        case .page4: "Connect with people"
        }
    }
    
    var subtitle: String {
        switch self {
        case .page1: "Your journey starts here"
        case .page2: "Discover a deeper a gaming experience\nwith the DualSense controller"
        case .page3: "Stream your PS5 to Mac\nor Apple devices."
        case .page4: "Reach out and make new friends"
        }
    }
    
    var index: CGFloat {
        switch self {
        case .page1: 0
        case .page2: 1
        case .page3: 2
        case .page4: 3
        }
    }
    
    var nextPage: PsPage {
        let index = Int(index) + 1
        if index < 4 {
            return PsPage.allCases[index]
        }
        
        return self
    }
    
    var previousPage: PsPage {
        let index = Int(index) - 1
        if index >= 0 {
            return PsPage.allCases[index]
        }
        
        return self
    }
}
