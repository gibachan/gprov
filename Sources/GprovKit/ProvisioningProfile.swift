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
    let teamID: String
    let uuid: String
}

extension ProvisioningProfile {
    init?(plist: Any) {
        guard let dict = plist as? [String: Any] else {
            return nil
        }

        self.name = dict["Name"] as? String ?? ""
        self.appIDName = dict["AppIDName"] as? String ?? ""
        self.teamID = dict["TeamIdentifier"] as? String ?? ""
        self.uuid = dict["UUID"] as? String ?? ""
    }
}

extension ProvisioningProfile: CustomStringConvertible {
    var description: String {
        "Name: \(name), App ID Name: \(appIDName), Team ID: \(teamID), UUID: \(uuid)"
    }
}
