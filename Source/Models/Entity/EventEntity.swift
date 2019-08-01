//
//  EventEntity.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation

struct EventEntity: Codable {

    var id: Int
    var title: String
    var location: String
    var date: Date?
    var isTBD: Bool
    var imageURL: URL?
    var isFavorite: Bool = false
    
}

extension EventEntity {
    init(_ remote: EventRemote) {
        self.id = remote.id
        self.title = remote.title
        self.location = remote.venue.location
        self.date = remote.date
        self.isTBD = remote.isDateTBD || remote.isTimeTBD
        self.imageURL = remote.performers.first(where: { $0.isPrimary ?? false })?.image
    }
}

extension EventEntity {
    static var mock: EventEntity = {
        let randomID = Int.random(in: 0...100)
        let randomBoolean = [true, false].randomElement()!
        let event = EventEntity(id: randomID,
                                title: "Beyonce vs. Rihanna",
                                location: "Austin, TX",
                                date: Date(),
                                isTBD: false,
                                imageURL: URL(string: "https://seatgeek.com/images/performers-landscape/beyonce-vs-rihanna-92adef/559309/huge.jpg")!,
                                isFavorite: randomBoolean)

        return event
    }()
}
