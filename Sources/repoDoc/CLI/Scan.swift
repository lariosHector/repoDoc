import ArgumentParser
import Foundation

struct Scan: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Scan a repository and print detected signals (stack, CI, key files)."
    )

    @Option(name: .shortAndLong, help: "Path to the repository (default: current directory).")
    var path: String?

    func run() throws {
        let repoURL = URL(fileURLWithPath: path ?? FileManager.default.currentDirectoryPath)
            .standardizedFileURL

        guard FileManager.default.fileExists(atPath: repoURL.path) else {
            throw ValidationError("Path does not exist: \(repoURL.path)")
        }

        let scanner = RepoScanner()
        let result = try scanner.scan(repoURL: repoURL)

        ConsolePrinter.printScan(result)
    }
}
