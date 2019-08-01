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
        let isFavorite = false

        cellData = SearchResultCellData(imageURL: imageURL,
                                        title: title,
                                        location: location,
                                        date: date,
                                        isFavorite: isFavorite)

        cell = SearchResultCell.instantiate()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConfigure() {
        cell.configure(with: cellData)

        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let formattedDate = formatter.string(from: cellData.date!)

        XCTAssertEqual(cell.titleLabel.text, cellData.title)
        XCTAssertEqual(cell.locationLabel.text, cellData.location)
        XCTAssertEqual(cell.dateLabel.text, formattedDate)
        // FIXME: Handle imageView - Requires us to swap ImageFetcher with something mocked
    }

    func testConfigureNilDate() {
        cellData = SearchResultCellData(imageURL: cellData.imageURL,
                                        title: cellData.title,
                                        location: cellData.location,
                                        date: nil,
                                        isFavorite: cellData.isFavorite)

        cell.configure(with: cellData)

        XCTAssertEqual(cell.titleLabel.text, cellData.title)
        XCTAssertEqual(cell.locationLabel.text, cellData.location)
        XCTAssertEqual(cell.dateLabel.text, "TBD")
    }

    func testPrepareForReuse() {
        cell = SearchResultCell.instantiate()
        cell.configure(with: cellData)
        cell.prepareForReuse()

        XCTAssertNil(cell.titleLabel.text, "SearchResultCell titleLabel is not prepared for reuse")
        XCTAssertNil(cell.locationLabel.text, "SearchResultCell locationLabel is not prepared for reuse")
        XCTAssertNil(cell.dateLabel.text, "SearchResultCell dateLabel is not prepared for reuse")
        XCTAssertNil(cell.eventImageView.image, "SearchResultCell eventImageView is not prepared for reuse")
    }


}
