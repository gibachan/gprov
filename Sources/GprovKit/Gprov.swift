//
//  Gprov.swift
//  
//
//  Created by Tatsuyuki Kobayashi on 2023/02/22.
//

import CoreFoundation
import CryptoKit
import Foundation

public struct Gprov {
    private let fileManager = FileManager.default
    private let provisioningProfilesDirectory = "Library/MobileDevice/Provisioning Profiles"

    public init() {}

    public func run(profileName: String?) {
        let profileNames = getProvisioningProfileNames()

        if let profileName {
            // Show corresponding provisiong profile detail
            if let fileName = profileNames.first(where: { $0 == profileName }) {
                if let profile = getProvisioningProfile(of: fileName) {
                    print("\(profile)")
                    return
                }
            }
            
            print("Invalid provisioning profile name")
        } else {
            // Show all provisioning profile list
            guard !profileNames.isEmpty else {
                print("Provisioning Profile is not found.")
                return
            }

            print("Provisioning Profiles:")
            profileNames.forEach { print($0) }
        }
    }
}

private extension Gprov {
    func getProvisioningProfileNames() -> [String] {
        let path = "\(fileManager.homeDirectoryForCurrentUser.path)/\(provisioningProfilesDirectory)"
        do {
            return try fileManager.contentsOfDirectory(atPath: path)
        } catch {
            print(error)
            return []
        }
    }

    func getProvisioningProfile(of fileName: String) -> ProvisioningProfile? {
        let path = "\(fileManager.homeDirectoryForCurrentUser.path)/\(provisioningProfilesDirectory)/\(fileName)"
        guard let data = fileManager.contents(atPath: path) as? NSData else {
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
}
