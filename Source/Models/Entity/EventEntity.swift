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
    var date: Date
    var isTBD: Bool
    var imageURL: URL
    var isFavorite: Bool
    
}
