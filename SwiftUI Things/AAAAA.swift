import SwiftUI

extension View {

    @ViewBuilder
    func ifAvailableiOS26<T: View, F: View>(
        _ transform: (Self) -> T,
        else fallback: ((Self) -> F)? = nil
    ) -> some View {
        if #available(iOS 26, *) {
            transform(self)
        } else if let fallback {
            fallback(self)
        } else {
            self
        }
    }
}

//// Solo iOS 26+
//.ifAvailableiOS26 {
//    $0.glassEffect(.regular.interactive())
//}
//
//// iOS 26+ con fallback
//.ifAvailableiOS26 {
//    $0.glassEffect(.regular.interactive())
//} else: {
//    $0.background(Color.blue)
//}
//
//// Solo iOS anteriores (sin transform en iOS 26)
//.ifAvailableiOS26({ $0 }, else: {
//    $0.background(Color.blue)
//})


extension View {

    @ViewBuilder
    func ifNotAvailableiOS26<T: View>(
        _ transform: (Self) -> T
    ) -> some View {
        if #available(iOS 26, *) {
            self
        } else {
            transform(self)
        }
    }
}

//    .ifNotAvailableiOS26 {
//        $0.background(Color.blue)
//    }
