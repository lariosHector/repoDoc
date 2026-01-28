import Foundation

enum AuthorDetector {

    /// Devuelve un string tipo "owner/repo" si el remote es GitHub/GitLab.
    /// Si no puede extraer slug, devuelve el remote completo.
    static func detectRepoOrigin(repoURL: URL) -> String? {
        // 1) Intento robusto usando git (recomendado)
        if let remote = gitRemoteOriginURL(repoURL: repoURL) {
            return extractSlugOrReturnRemote(remote)
        }

        // 2) Fallback: leer config resolviendo .git (dir o gitdir file)
        if let remote = remoteFromGitConfig(repoURL: repoURL) {
            return extractSlugOrReturnRemote(remote)
        }

        return nil
    }

    // MARK: - Strategy 1: git config
    private static func gitRemoteOriginURL(repoURL: URL) -> String? {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["git", "-C", repoURL.path, "config", "--get", "remote.origin.url"]

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = Pipe()

        do {
            try process.run()
            process.waitUntilExit()
            guard process.terminationStatus == 0 else { return nil }

            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let out = String(data: data, encoding: .utf8)?
                .trimmingCharacters(in: .whitespacesAndNewlines)

            return (out?.isEmpty == false) ? out : nil
        } catch {
            return nil
        }
    }

    // MARK: - Strategy 2: read .git/config (supports worktrees)
    private static func remoteFromGitConfig(repoURL: URL) -> String? {
        guard let gitDir = resolveGitDir(repoURL: repoURL) else { return nil }
        let configURL = gitDir.appendingPathComponent("config")

        guard let content = try? String(contentsOf: configURL, encoding: .utf8) else { return nil }

        // Parse simple INI-like: find section [remote "origin"] then its url =
        var inOriginRemote = false

        for rawLine in content.split(separator: "\n") {
            let line = rawLine.trimmingCharacters(in: .whitespacesAndNewlines)

            if line.hasPrefix("[") && line.hasSuffix("]") {
                inOriginRemote = (line == #"[remote "origin"]"#)
                continue
            }

            guard inOriginRemote else { continue }

            if line.hasPrefix("url") {
                // url = something
                if let idx = line.firstIndex(of: "=") {
                    let value = line[line.index(after: idx)...]
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    return value.isEmpty ? nil : value
                }
            }
        }

        return nil
    }

    /// Si .git es directorio -> return /repo/.git
    /// Si .git es archivo con "gitdir: <path>" -> return <path> como URL (absoluto o relativo)
    private static func resolveGitDir(repoURL: URL) -> URL? {
        let gitURL = repoURL.appendingPathComponent(".git")

        var isDir: ObjCBool = false
        if FileManager.default.fileExists(atPath: gitURL.path, isDirectory: &isDir) {
            if isDir.boolValue {
                return gitURL
            } else {
                // .git es archivo: contiene "gitdir: ..."
                guard let content = try? String(contentsOf: gitURL, encoding: .utf8) else { return nil }
                let trimmed = content.trimmingCharacters(in: .whitespacesAndNewlines)
                guard trimmed.lowercased().hasPrefix("gitdir:") else { return nil }

                let pathPart = trimmed.dropFirst("gitdir:".count)
                    .trimmingCharacters(in: .whitespacesAndNewlines)

                // Puede ser relativo al repo
                let resolvedPath: String
                if pathPart.hasPrefix("/") {
                    resolvedPath = String(pathPart)
                } else {
                    resolvedPath = repoURL.appendingPathComponent(String(pathPart)).path
                }
                return URL(fileURLWithPath: resolvedPath).standardizedFileURL
            }
        }

        return nil
    }

    // MARK: - Slug extraction
    private static func extractSlugOrReturnRemote(_ remote: String) -> String {
        if let slug = extractGitHubOrGitLabSlug(from: remote) {
            return slug
        }
        return remote
    }

    /// Soporta:
    /// - git@github.com:owner/repo.git
    /// - https://github.com/owner/repo.git
    /// - git@gitlab.com:owner/repo.git
    /// - https://gitlab.com/owner/repo.git
    private static func extractGitHubOrGitLabSlug(from remote: String) -> String? {
        let cleaned = remote.replacingOccurrences(of: ".git", with: "")

        // SSH: git@domain:owner/repo
        if let range = cleaned.range(of: ":"),
           cleaned.contains("@"),
           cleaned.contains("github.com") || cleaned.contains("gitlab.com") {
            let slug = cleaned[range.upperBound...]
            return slug.isEmpty ? nil : String(slug)
        }

        // HTTPS: https://domain/owner/repo
        if let url = URL(string: cleaned),
           let host = url.host,
           (host.contains("github.com") || host.contains("gitlab.com")) {
            let path = url.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            return path.isEmpty ? nil : path
        }

        return nil
    }
    static func extractOwner(from remote: String) -> String? {
        // Caso SSH: git@host:owner/repo.git
        if let colonRange = remote.firstIndex(of: ":") {
            let afterColon = remote[remote.index(after: colonRange)...]
            if let slashRange = afterColon.firstIndex(of: "/") {
                return String(afterColon[..<slashRange])
            }
        }

        // Caso HTTPS: https://host/owner/repo.git
        if let url = URL(string: remote),
        let path = url.path.split(separator: "/").first {
            return String(path)
        }

        return nil
    }

}
