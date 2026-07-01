import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct iOS26MacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        iOS26OnlyMacro.self,
        CodeSnippetMacro.self,
    ]
}
