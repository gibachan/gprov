//
//  Open.swift
//  
//
//  Created by Tatsuyuki Kobayashi on 2023/02/23.
//

import ArgumentParser
import GprovKit

struct Open: ParsableCommand {
    static let configuration = CommandConfiguration(
      abstract: "Open the directory where provisioning profiles are stored."
    )

    mutating func run() throws {
        Gprov().open()
    }
}
