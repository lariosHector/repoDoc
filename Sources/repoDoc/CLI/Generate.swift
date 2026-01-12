import ArgumentParser
import Foundation

struct Generate: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Generate documentation files from repository analysis."
    )

    @Option(name: .shortAndLong, help: "Path to the repository (default: current directory).")
    var path: String?

    @Option(name: .shortAndLong, help: "Max depth for directory tree.")
    var depth: Int = 3

    func run() throws {
        let repoURL = URL(fileURLWithPath: path ?? FileManager.default.currentDirectoryPath)
            .standardizedFileURL

        let scanner = RepoScanner()
        let scanResult = try scanner.scan(repoURL: repoURL)

        let generator = DocGenerator(repoURL: repoURL, scanResult: scanResult)
        try generator.generateOverview()
        try generator.generateStructure(maxDepth: depth)

        print(" - Documentation generated successfully -")
    }
}
