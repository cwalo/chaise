//
//  ISO8601NoZuluTests.swift
//  chaiseTests
//
//  Created by Corey Walo on 8/1/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import XCTest
@testable import chaise

final class ISO8601NoZuluTests: XCTestCase {

    func testFormatterCorrectFormat() {
        let dateString = "2019-08-02T17:00:00"
        let formatter = DateFormatter.ISO8601NoZulu()
        let date = formatter.date(from: dateString)

        XCTAssertNotNil(date, "ISO8601NoZulu DateFormatter could not parse time.")
    }
}
