//
//  ProvisioningProfile.swift
//  
//
//  Created by Tatsuyuki Kobayashi on 2023/02/22.
//

import Foundation

struct ProvisioningProfile {
    let name: String
    let appIDName: String
    let teamIDs: [String]
    let uuid: String
    let platforms: [String]
    let creationDate: Date?
    let expirationDate: Date?
    let certificates: [Certificate]
}

extension ProvisioningProfile {
    init?(plist: Any) {
        guard let dict = plist as? [String: Any] else {
            return nil
        }

        self.name = dict["Name"] as? String ?? ""
        self.appIDName = dict["AppIDName"] as? String ?? ""
        self.teamIDs = dict["TeamIdentifier"] as? [String] ?? []
        self.uuid = dict["UUID"] as? String ?? ""
        self.platforms = dict["Platform"] as? [String] ?? []
        self.creationDate = dict["CreationDate"] as? Date
        self.expirationDate = dict["ExpirationDate"] as? Date

        let certificates = (dict["DeveloperCertificates"] as? [Data] ?? [])
            .compactMap { Certificate(data: $0) }
        self.certificates = certificates
    }
}

extension ProvisioningProfile: CustomStringConvertible {
    var createdAt: String {
        if let creationDate {
            return creationDate.description
        } else {
            return ""
        }
    }
    var expireAt: String {
        if let expirationDate {
            return expirationDate.description
        } else {
            return ""
        }
    }
    var isExpired: Bool {
        if let expirationDate {
            return expirationDate < Date()
        } else {
            return false
        }
    }

    var description: String {
        var certificatesString = ""
        certificates.forEach {
            certificatesString += "    \($0.name)\n"
        }

        return """
        Name: \(name)
        App ID Name: \(appIDName)
        Team ID: \(teamIDs)
        UUID: \(uuid)"
        Platform: \(platforms)
        Creation Date: \(createdAt)
        Expiration Date: \(expireAt) \(isExpired ? "(Expired)" : "")
        Certificates:
        \(certificatesString)
        """
    }
}
