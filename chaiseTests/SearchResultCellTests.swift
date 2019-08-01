//
//  SearchResultCellTests.swift
//  chaiseTests
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import XCTest
@testable import chaise

class SearchResultCellTests: XCTestCase {

    var cell: SearchResultCell!
    var cellData: SearchResultCellData!

    override func setUp() {
        let imageURL = URL(string: "https://seatgeek.com/images/performers-landscape/beyonce-vs-rihanna-92adef/559309/huge.jpg")!
        let title = "Beyonce vs. Rihanna"
        let location = "Austin, TX"
        let date = Date()

        cellData = SearchResultCellData(imageURL: imageURL,
                                        title: title,
                                        location: location,
                                        date: date)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConfigure() {
        cell = SearchResultCell.instantiate()
        cell.configure(with: cellData)

        XCTAssertTrue(cell.titleLabel.text == cellData.title, "SearchResultCell titleLabel.text is not configured")
        XCTAssertTrue(cell.locationLabel.text == cellData.location, "SearchResultCell locationLabel.text is not configured")
        XCTAssertTrue(cell.dateLabel.text == cellData.date.description , "SearchResultCell dateLabel.text is not configured")
        // FIXME: Handle imageView - Requires us to swap ImageFetcher with something mocked
    }

    func testPrepareForReuse() {
        cell = SearchResultCell.instantiate()
        cell.configure(with: cellData)
        cell.prepareForReuse()

        XCTAssertTrue(cell.titleLabel.text == nil, "SearchResultCell titleLabel is not prepared for reuse")
        XCTAssertTrue(cell.locationLabel.text == nil, "SearchResultCell locationLabel is not prepared for reuse")
        XCTAssertTrue(cell.dateLabel.text == nil, "SearchResultCell dateLabel is not prepared for reuse")
        XCTAssertTrue(cell.eventImageView.image == nil, "SearchResultCell eventImageView is not prepared for reuse")
    }


}
