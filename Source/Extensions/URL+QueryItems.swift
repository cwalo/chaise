//
//  URL+QueryItems.swift
//  chaise
//
//  Created by Corey Walo on 7/31/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation

extension URL {
    
    func appendingQueryItems(_ items: [String: String]) -> URL? {
        guard var components = URLComponents(string: absoluteString) else { return nil }
        var allItems = components.queryItems ?? []
        let newItems = items.map { URLQueryItem(name: $0, value: $1) }
        allItems.append(contentsOf: newItems)
        components.queryItems = allItems
        return components.url
    }
}
