import ArgumentParser
import GprovKit

@main
struct Main: ParsableCommand {
    public static let configuration = CommandConfiguration(
      abstract: "🔍 Explore provisiong profiles.",
      version: "0.0.0",
      subcommands: [Profile.self, List.self]
    )
}
