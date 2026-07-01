import SwiftSyntax
import SwiftSyntaxMacros

public struct iOS26OnlyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.argumentList.first?.expression else {
            fatalError("compiler bug: #iOS26Only requires a trailing closure")
        }

        return """
        if #available(iOS 26.0, *) {
            \(argument)
        } else {
            Text("iOS 26 device required")
        }
        """
    }
}
