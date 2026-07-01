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

/// Captures the source code of an expression and returns it alongside the evaluated value.
///
/// Use this to display usage code snippets in a StoryBook without duplicating the view expression.
/// The expression is evaluated normally; its source text is captured at compile time.
///
/// ```swift
/// let (view, code) = #CodeSnippet(CustomMenuView(style: .glass) {
///     Image(systemName: "calendar")
/// } content: {
///     DateFilterView()
/// })
/// ```
@freestanding(expression)
public macro CodeSnippet<Result>(_ expression: Result) -> (value: Result, code: String) = #externalMacro(module: "iOS26MacrosMacros", type: "CodeSnippetMacro")
