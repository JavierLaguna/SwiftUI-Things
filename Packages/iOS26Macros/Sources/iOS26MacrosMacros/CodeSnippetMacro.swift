import SwiftSyntax
import SwiftSyntaxMacros

public struct CodeSnippetMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
            throw MacroError.message("#CodeSnippet requires an expression argument. Usage: #CodeSnippet(MyView(…))")
        }

        let sourceText = argument.description
        let trimmed = sourceText.trimmingCharacters(in: .newlines)
        let dedented = dedent(trimmed)
        let escaped = escapeForStringLiteral(dedented)

        return "(value: \(argument), code: \"\(raw: escaped)\")"
    }

    private static func dedent(_ text: String) -> String {
        let lines = text.components(separatedBy: .newlines)
        guard lines.count > 1 else { return text }

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
