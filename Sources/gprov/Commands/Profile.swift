//
//  Profile.swift
//  
//
//  Created by Tatsuyuki Kobayashi on 2023/02/22.
//

import ArgumentParser
import GprovKit

struct Profile: ParsableCommand {
    static let configuration = CommandConfiguration(
      abstract: "Show the detail of a provisioning profile."
    )

    @Argument( help: "The name of Provisionig profile file.")
    var profile: String

    mutating func run() throws {
        Gprov().detail(of: profile)
    }
}

