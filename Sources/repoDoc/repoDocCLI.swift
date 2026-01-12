import ArgumentParser
import Foundation

@main
struct RepoDocCLI: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "repodoc",
        abstract: "Generate documentation from repository structure.",
        version: "0.1.0",
        subcommands: [Scan.self, Generate.self, Score.self],
    )
}
