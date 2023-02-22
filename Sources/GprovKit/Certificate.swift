//
//  Certificate.swift
//  
//
//  Created by Tatsuyuki Kobayashi on 2023/02/22.
//

import Foundation

struct Certificate {
    let name: String
}

extension Certificate {
    init?(data: Data) {
        let cfData: CFData = data as CFData
        guard let secCertificate: SecCertificate = SecCertificateCreateWithData(nil, cfData) else {
            return nil
        }
        guard let summaryRef: CFString = SecCertificateCopySubjectSummary(secCertificate) else {
            return nil
        }

        self.name = summaryRef as String
    }
}


