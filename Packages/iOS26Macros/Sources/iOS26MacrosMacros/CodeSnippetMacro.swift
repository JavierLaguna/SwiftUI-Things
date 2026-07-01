import SwiftSyntax
import SwiftSyntaxMacros

public struct CodeSnippetMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        if let trailingClosure = node.trailingClosure {
            return sourceText(from: trailingClosure)
        }

        if let argument = node.arguments.first?.expression,
           let closure = argument.as(ClosureExprSyntax.self)
        {
            return sourceText(from: closure)
        }

        throw MacroError.message("#CodeSnippet requires a trailing closure")
    }

    private static func sourceText(from closure: ClosureExprSyntax) -> ExprSyntax {
        let sourceText = closure.statements.description
        let trimmed = sourceText.trimmingCharacters(in: .newlines)
        let dedented = dedent(trimmed)

        return "\"\(raw: escapeForStringLiteral(dedented))\""
    }

    private static func dedent(_ text: String) -> String {
        let lines = text.components(separatedBy: .newlines)
        let nonEmpty = lines.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        guard let minIndent = nonEmpty.map({ $0.prefix(while: { $0.isWhitespace }).count }).min(),
              minIndent > 0
        else { return text }

        return lines.map { line in
            guard line.count >= minIndent else { return line }
            return String(line.dropFirst(minIndent))
        }.joined(separator: "\n")
    }

    private static func escapeForStringLiteral(_ text: String) -> String {
        text
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
            .replacingOccurrences(of: "\n", with: "\\n")
            .replacingOccurrences(of: "\r", with: "\\r")
            .replacingOccurrences(of: "\t", with: "\\t")
    }
}

enum MacroError: Error, CustomStringConvertible {
    case message(String)

    var description: String {
        switch self {
        case .message(let msg): msg
        }
    }
}
