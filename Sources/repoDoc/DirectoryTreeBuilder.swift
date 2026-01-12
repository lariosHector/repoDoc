import Foundation

enum DirectoryTreeBuilder {

    static func buildTree(root: URL, maxDepth: Int) -> String {
        return walk(url: root, prefix: "", depth: 0, maxDepth: maxDepth)
    }

    private static func walk(
        url: URL,
        prefix: String,
        depth: Int,
        maxDepth: Int
    ) -> String {
        guard depth <= maxDepth else { return "" }

        let fm = FileManager.default
        var output = ""

        guard let items = try? fm.contentsOfDirectory(
            at: url,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles]
        ) else {
            return ""
        }

        let sorted = items.sorted { $0.lastPathComponent < $1.lastPathComponent }

        for (index, item) in sorted.enumerated() {
            let isLast = index == sorted.count - 1
            let connector = isLast ? "└── " : "├── "

            output += "\(prefix)\(connector)\(item.lastPathComponent)\n"

            if (try? item.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true,
               !item.lastPathComponent.contains(".git") {
                let newPrefix = prefix + (isLast ? "    " : "│   ")
                output += walk(
                    url: item,
                    prefix: newPrefix,
                    depth: depth + 1,
                    maxDepth: maxDepth
                )
            }
        }

        return output
    }
}
