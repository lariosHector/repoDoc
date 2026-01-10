import Foundation

enum CIDetector {
    static func detect(from files: Set<String>) -> [String] {
        var ci: [String] = []

        if files.contains(where: { $0.hasPrefix(".github/workflows/") }) {
            ci.append("GitHub Actions (.github/workflows)")
        }
        if files.contains(".gitlab-ci.yml") {
            ci.append("GitLab CI (.gitlab-ci.yml)")
        }

        return ci.isEmpty ? ["None detected"] : ci
    }
}
