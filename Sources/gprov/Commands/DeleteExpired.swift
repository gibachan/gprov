//
//  DeleteExpired.swift
//  
//
//  Created by Tatsuyuki Kobayashi on 2023/03/25.
//

import ArgumentParser
import GprovKit

struct DeleteExpired: ParsableCommand {
    static let configuration = CommandConfiguration(
      abstract: "Delete expired provisioning profiles."
    )

    mutating func run() throws {
        Gprov().deleteExpired()
    }
}
