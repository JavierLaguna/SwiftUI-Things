import SwiftUI

/// Expands to `if #available(iOS 26.0, *) { … } else { Text("iOS 26 device required") }`.
///
/// Use this to wrap a view that requires iOS 26+ APIs without repeating the availability guard.
///
/// ```swift
/// var body: some View {
///     #iOS26Only {
///         VStack {
///             Text("iOS 26+ content here")
///         }
///     }
/// }
/// ```
@freestanding(expression)
public macro iOS26Only<Content: View>(@ViewBuilder content: () -> Content) -> any View = #externalMacro(module: "iOS26MacrosMacros", type: "iOS26OnlyMacro")

/// Captures the source code of the given closure body and returns it as a string.
///
/// Use this to display usage code snippets in a StoryBook without duplicating hardcoded strings.
/// The closure body is never executed — only parsed at compile time for its source text.
///
/// ```swift
/// let code = #CodeSnippet {
///     CustomMenuView(style: selectedOption) {
///         Image(systemName: "calendar")
///     } content: {
///         DateFilterView()
///     }
/// }
/// ```
@freestanding(expression)
public macro CodeSnippet<Result>(_ body: () -> Result) -> String = #externalMacro(module: "iOS26MacrosMacros", type: "CodeSnippetMacro")
