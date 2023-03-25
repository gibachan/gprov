//
//  Gprov.swift
//  
//
//  Created by Tatsuyuki Kobayashi on 2023/02/22.
//

import AppKit
import CoreFoundation
import CryptoKit
import Foundation

public struct Gprov {
    private let fileManager = FileManager.default
    private let provisioningProfilesDirectory = "Library/MobileDevice/Provisioning Profiles"

    public init() {}

    public func list(for type: ListType) {
        let profileNames = getProvisioningProfileNames()
        if profileNames.isEmpty {
            print("Provisioning Profile is not found.")
        } else {
            switch type {
            case .all:
                printAllProfiles(profileNames)
            case .available:
                printAvailableProfiles(profileNames)
            case .expired:
                printExpiredProfiles(profileNames)
            }
        }
    }

    public func detail(of profileName: String) {
        let profileNames = getProvisioningProfileNames()
        if let fileName = profileNames.first(where: { $0 == profileName }) {
            if let profile = getProvisioningProfile(of: fileName) {
                print("\(profile)")
                return
            }
        }

        print("Invalid provisioning profile name")
    }

    public func open() {
        let url = fileManager
            .homeDirectoryForCurrentUser
            .appendingPathComponent(provisioningProfilesDirectory)
        NSWorkspace.shared.open(url)
    }
}

private extension Gprov {
    var parentPath: String {
        return "\(fileManager.homeDirectoryForCurrentUser.path)/\(provisioningProfilesDirectory)"
    }

    func getProvisioningProfileNames() -> [String] {
        do {
            return try fileManager.contentsOfDirectory(atPath: parentPath)
        } catch {
            print(error)
            return []
        }
    }

    func getProvisioningProfile(of fileName: String) -> ProvisioningProfile? {
        let filePath = "\(parentPath)/\(fileName)"
        guard let data = fileManager.contents(atPath: filePath) as? NSData else {
            preconditionFailure("\(fileName) could not be read")
        }

        var decoder: CMSDecoder?
        CMSDecoderCreate(&decoder)
        guard let decoder else {
            preconditionFailure("CMSDecoder cannot be created")
        }

        var cfData: CFData?
        CMSDecoderUpdateMessage(decoder, data.bytes, data.length)
        CMSDecoderFinalizeMessage(decoder)
        CMSDecoderCopyContent(decoder, &cfData)

        guard let plistData = cfData as? Data else {
            return nil
        }

        do {
            let plist = try PropertyListSerialization.propertyList(from: plistData, format: nil)
            return ProvisioningProfile(plist: plist)
        } catch {
            return nil
        }
    }

    func printAllProfiles(_ profileNames: [String]) {
        print("Provisioning Profiles:")

        profileNames.forEach {
            let filePath = "\(parentPath)/\($0)"
            if let profile = getProvisioningProfile(of: $0) {
                print("\(filePath) \"\(profile.name)\"")
            } else {
                print("\(filePath) \"Invalid provisioning profile")
            }
        }
    }

    func printAvailableProfiles(_ profileNames: [String]) {
        print("Available provisioning Profiles:")

        profileNames.forEach {
            let filePath = "\(parentPath)/\($0)"
            if let profile = getProvisioningProfile(of: $0),
               !profile.isExpired {
                print("\(filePath) \"\(profile.name)\"")
            }
        }
    }

    func printExpiredProfiles(_ profileNames: [String]) {
        print("Expired provisioning Profiles:")

        profileNames.forEach {
            let filePath = "\(parentPath)/\($0)"
            if let profile = getProvisioningProfile(of: $0),
               profile.isExpired {
                print("\(filePath) \"\(profile.name)\"")
            }
        }
    }
}
