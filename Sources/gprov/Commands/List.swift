//
//  List.swift
//  
//
//  Created by Tatsuyuki Kobayashi on 2023/02/22.
//

import ArgumentParser
import GprovKit

struct List: ParsableCommand {
    static let configuration = CommandConfiguration(
      abstract: "List provisioning profiles."
    )

    @Option(
        name: .shortAndLong,
        help: "The type of information to be listed. Available types: all, available, expired",
        transform: { ListType(rawValue: $0.lowercased()) }
    )
    var type: ListType? = nil

    mutating func run() throws {
        Gprov().list(for: type ?? .all)
    }
}
