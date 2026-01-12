import ArgumentParser
import Foundation

struct Score: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Evaluate documentation health of the repository."
    )

    @Option(name: .shortAndLong, help: "Path to the repository (default: current directory).")
    var path: String?

    func run() throws {
        let repoURL = URL(fileURLWithPath: path ?? FileManager.default.currentDirectoryPath)
            .standardizedFileURL

        let scanner = RepoScanner()
        let scanResult = try scanner.scan(repoURL: repoURL)

        let scorer = DocScorer()
        let report = scorer.evaluate(scanResult)

        ConsolePrinter.printScore(report)
    }
}
