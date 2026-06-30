import SwiftUI

// MARK: - View Modifiers

extension View {

    /// Applies a transformation only on iOS 26+.
    ///
    /// ```swift
    /// .ifAvailableiOS26 {
    ///     $0.glassEffect(.regular.interactive())
    /// }
    /// ```
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

    /// Applies a transformation only on versions below iOS 26.
    ///
    /// ```swift
    /// .ifNotAvailableiOS26 {
    ///     $0.background(Color.blue)
    /// }
    /// ```
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
