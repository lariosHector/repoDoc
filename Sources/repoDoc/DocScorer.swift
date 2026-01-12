import Foundation

struct ScoreReport {
    let score: Int
    let missing: [String]
    let suggestions: [String]
}

final class DocScorer {

    func evaluate(_ scan: ScanResult) -> ScoreReport {
        var score = 0
        var missing: [String] = []
        var suggestions: [String] = []

        // README
        if scan.keyFilesFound.contains("README.md") {
            score += 20
        } else {
            missing.append("README.md")
            suggestions.append("Add a README to describe the project purpose and usage.")
        }

        // LICENSE
        if scan.keyFilesFound.contains(where: { $0.hasPrefix("LICENSE") }) {
            score += 10
        } else {
            missing.append("LICENSE")
            suggestions.append("Add a LICENSE file to clarify usage rights.")
        }

        // CONTRIBUTING
        if scan.keyFilesFound.contains("CONTRIBUTING.md") {
            score += 10
        } else {
            missing.append("CONTRIBUTING.md")
            suggestions.append("Provide contribution guidelines for collaborators.")
        }

        // Tests
        if scan.detectedStacks.contains(where: { $0.lowercased().contains("swift") }) {
            // heurística simple: carpeta Tests
            if FileManager.default.fileExists(atPath: "Tests") {
                score += 20
            } else {
                missing.append("Tests")
                suggestions.append("Add tests to improve reliability.")
            }
        }

        // CI
        if !scan.ciSignals.contains("None detected") {
            score += 20
        } else {
            missing.append("CI configuration")
            suggestions.append("Add CI (e.g., GitHub Actions) to automate checks.")
        }

        // Docs
        if FileManager.default.fileExists(atPath: "docs") {
            score += 20
        } else {
            missing.append("docs/")
            suggestions.append("Create a docs/ folder for structured documentation.")
        }

        if score > 100 { score = 100 }

        return ScoreReport(score: score, missing: missing, suggestions: suggestions)
    }
}
