//
//  PerformerRemote.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation

struct PerformerRemote: Codable {

    enum CodingKeys: String, CodingKey {
        case image
        case isPrimary = "primary"
    }

    var image: URL
    var isPrimary: Bool
}
