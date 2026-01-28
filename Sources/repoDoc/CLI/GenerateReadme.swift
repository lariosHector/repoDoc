import ArgumentParser
import Foundation

struct GenerateReadme: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "generate-readme",
        abstract: "Generate a README.md using scan signals (stack, CI, key files) and repository structure."
    )

    @Option(name: .shortAndLong, help: "Path to the repository (default: current directory).")
    var path: String?

    @Option(name: .shortAndLong, help: "Max depth for directory tree.")
    var depth: Int = 3

    @Flag(name: .long, help: "Overwrite README.md if it already exists.")
    var force: Bool = false

    func run() throws {
        let repoURL = URL(fileURLWithPath: path ?? FileManager.default.currentDirectoryPath)
            .standardizedFileURL

        let scanner = RepoScanner()
        let scanResult = try scanner.scan(repoURL: repoURL)

        // Árbol del repo (sin .git, con profundidad)
        let tree = DirectoryTreeBuilder.buildTree(root: repoURL, maxDepth: depth)

        let generator = ReadmeGenerator(repoURL: repoURL, scanResult: scanResult)
        try generator.generate(tree: tree, force: force)

        print("README.md generated successfully.")
    }
}
