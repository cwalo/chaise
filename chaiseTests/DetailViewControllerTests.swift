//
//  DetailViewControllerTests.swift
//  chaiseTests
//
//  Created by Corey Walo on 7/31/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import XCTest
@testable import chaise

class DetailViewControllerTests: XCTestCase {

    var viewController: DetailViewController!
    var event: EventEntity!

    override func setUp() {
        viewController = DetailViewController.instantiate()
        event = EventEntity.mock
    }

    func testConfigure() {
        viewController.event = event
        _ = viewController.view // trigger viewDidLoad

        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let formattedDate = event.date != nil ? formatter.string(from: event.date!) : "TBD"

        XCTAssertTrue(viewController.title == event.title, "DetailViewController title is not configured")
        XCTAssertTrue(viewController.dateLabel.text == formattedDate, "DetailViewController dateLabel is not configured")
        XCTAssertTrue(viewController.locationLabel.text == event.location, "DetailViewController locationLabel is not configured")
        // FIXME: Handle image
    }


}
