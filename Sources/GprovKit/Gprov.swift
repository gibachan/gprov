//
//  Gprov.swift
//  
//
//  Created by Tatsuyuki Kobayashi on 2023/02/22.
//

import Foundation

public struct Gprov {
    private let provisioningProfilesDirectory = "Library/MobileDevice/Provisioning Profiles"

    public init() {}

    public func run() {
        print("Provisioning Profiles:")
        getProvisioningProfileNames().forEach { print($0) }
    }
}

private extension Gprov {
    func getProvisioningProfileNames() -> [String] {
        let fileManager = FileManager.default
        let path = "\(fileManager.homeDirectoryForCurrentUser.path)/\(provisioningProfilesDirectory)"
        do {
            return try fileManager.contentsOfDirectory(atPath: path)
        } catch {
            print(error)
            return []
        }
    }
}
