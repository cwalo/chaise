//
//  DateFormatter+ISONoZulu.swift
//  chaise
//
//  Created by Corey Walo on 8/1/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation

fileprivate var cachedFormatter: DateFormatter?

extension DateFormatter {
    static func ISO8601NoZulu() -> DateFormatter {
        if let cachedFormatter = cachedFormatter {
            return cachedFormatter
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            cachedFormatter = formatter
            return formatter
        }
    }
}
