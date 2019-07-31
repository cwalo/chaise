//
//  EventsRemote.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation

struct ResponseMeta: Codable {

    enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case total
        case page
    }

    var perPage: Int = 0
    var total: Int = 0
    var page: Int = 0
}

struct EventsRemote: Codable {
    var meta: ResponseMeta?
    var events: [EventRemote]
}
