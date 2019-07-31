//
//  VenueRemote.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation

struct VenueRemote: Codable {

    enum CodingKeys: String, CodingKey {
        case location = "display_location"
    }

    var location: String
}
