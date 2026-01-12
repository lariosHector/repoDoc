import Foundation

enum ConsolePrinter {
    static func printScan(_ result: ScanResult) {
        print("RepoDoc Scan")
        print("Path: \(result.repoPath)")
        print("")

        print("Detected Stack:")
        for s in result.detectedStacks {
            print("  - \(s)")
        }
        print("")

        print("Key Files Found:")
        if result.keyFilesFound.isEmpty {
            print("  (none)")
        } else {
            for f in result.keyFilesFound {
                print("  ✅ \(f)")
            }
        }
        print("")

        print("Key Files Missing:")
        if result.keyFilesMissing.isEmpty {
            print("  (none)")
        } else {
            for f in result.keyFilesMissing {
                print("  ❌ \(f)")
            }
        }
        print("")

        print("CI Signals:")
        for c in result.ciSignals {
            print("  - \(c)")
        }
        print("")
    }
    static func printScore(_ report: ScoreReport) {
        print("📊 Documentation Health Score")
        print("Score: \(report.score) / 100\n")

        if report.missing.isEmpty {
            print("✅ No missing documentation elements detected.\n")
        } else {
            print("❌ Missing:")
            for m in report.missing {
                print("  - \(m)")
            }
            print("")
        }

        if !report.suggestions.isEmpty {
            print("💡 Suggestions:")
            for s in report.suggestions {
                print("  - \(s)")
            }
            print("")
        }
    }

}
