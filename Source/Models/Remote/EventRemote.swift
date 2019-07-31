//
//  EventRemote.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation

struct EventRemote: Codable {

    enum CodingKeys: String, CodingKey {
        case date = "datetime_local"
        case id
        case isTimeTBD = "time_tbd"
        case isDateTBD = "date_tbd"
        case performers
        case title
        case venue
    }

    var date: Date
    var id: Int
    var isTimeTBD: Bool
    var isDateTBD: Bool
    var performers: [PerformerRemote]
    var title: String
    var venue: VenueRemote
}
