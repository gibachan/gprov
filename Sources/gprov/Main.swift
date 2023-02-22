import ArgumentParser
import GprovKit

import ArgumentParser

@main
struct Main: ParsableCommand {
    @Option(name: .shortAndLong, help: "Name of Provisionig profile file")
    var profile: String? = nil

    mutating func run() throws {
        Gprov().run(profileName: profile)
    }
}
