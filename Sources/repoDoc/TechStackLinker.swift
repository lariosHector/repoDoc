import Foundation

struct TechInfo {
    let display: String
    let url: String
}

enum TechStackLinker {
    static func link(for detectedStack: String) -> TechInfo? {
        let s = detectedStack.lowercased()

        // Swift / SPM
        if s.contains("swift package manager") || s.contains("spm") {
            return TechInfo(display: "Swift Package Manager", url: "https://www.swift.org/package-manager/")
        }
        if s.contains("swift") {
            return TechInfo(display: "Swift", url: "https://www.swift.org")
        }

        // Node / Python / Java (por si detectas repos mixtos)
        if s.contains("node") {
            return TechInfo(display: "Node.js", url: "https://nodejs.org")
        }
        if s.contains("python") {
            return TechInfo(display: "Python", url: "https://www.python.org")
        }
        if s.contains("maven") || s.contains("java") {
            return TechInfo(display: "Java", url: "https://www.oracle.com/java/")
        }
        if s.contains("gradle") {
            return TechInfo(display: "Gradle", url: "https://gradle.org")
        }

        // GitHub Actions
        if s.contains("github actions") {
            return TechInfo(display: "GitHub Actions", url: "https://docs.github.com/actions")
        }

        return nil
    }
}
