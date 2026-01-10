import Foundation

struct ScanResult {
    let repoPath: String
    let detectedStacks: [String]
    let keyFilesFound: [String]
    let keyFilesMissing: [String]
    let ciSignals: [String]
}

final class RepoScanner {
    private let fm = FileManager.default

    // Puedes ir creciendo esta lista conforme avances
    private let keyFiles = [
        "README.md",
        "LICENSE",
        "LICENSE.md",
        ".gitignore",
        "CONTRIBUTING.md",
        "CHANGELOG.md"
    ]

    func scan(repoURL: URL) throws -> ScanResult {
        let files = try listAllRelativePaths(root: repoURL)

        let found = keyFiles.filter { files.contains($0) }
        let missing = keyFiles.filter { !files.contains($0) }

        let stacks = StackDetector.detect(from: files)
        let ci = CIDetector.detect(from: files)

        return ScanResult(
            repoPath: repoURL.path,
            detectedStacks: stacks,
            keyFilesFound: found,
            keyFilesMissing: missing,
            ciSignals: ci
        )
    }

    private func listAllRelativePaths(root: URL) throws -> Set<String> {
        let enumerator = fm.enumerator(
            at: root,
            includingPropertiesForKeys: [.isDirectoryKey, .isRegularFileKey],
            options: [.skipsHiddenFiles],
            errorHandler: { _, _ in true }
        )

        var results = Set<String>()

        while let item = enumerator?.nextObject() as? URL {
            // Evita meterte a .git (ruidoso)
            if item.pathComponents.contains(".git") {
                enumerator?.skipDescendants()
                continue
            }

            let rel = item.path.replacingOccurrences(of: root.path + "/", with: "")
            results.insert(rel)
        }

        return results
    }
}
