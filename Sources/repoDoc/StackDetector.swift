import Foundation

enum StackDetector {
    static func detect(from files: Set<String>) -> [String] {
        var stacks: [String] = []

        // Swift
        if files.contains("Package.swift") { stacks.append("Swift (Swift Package Manager)") }

        // Node
        if files.contains("package.json") { stacks.append("Node.js (package.json)") }

        // Python
        if files.contains("pyproject.toml") { stacks.append("Python (pyproject.toml)") }
        else if files.contains("requirements.txt") { stacks.append("Python (requirements.txt)") }

        // Java
        if files.contains("pom.xml") { stacks.append("Java (Maven)") }
        if files.contains("build.gradle") || files.contains("build.gradle.kts") { stacks.append("Java/Kotlin (Gradle)") }

        // iOS / Apple projects
        if files.contains(where: { $0.hasSuffix(".xcodeproj/project.pbxproj") }) { stacks.append("Xcode Project (.xcodeproj)") }
        if files.contains(where: { $0.hasSuffix(".xcworkspace/contents.xcworkspacedata") }) { stacks.append("Xcode Workspace (.xcworkspace)") }

        return stacks.isEmpty ? ["Unknown (no stack signals found)"] : stacks
    }
}
