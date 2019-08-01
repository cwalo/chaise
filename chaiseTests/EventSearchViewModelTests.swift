//
//  EventSearchViewModelTests.swift
//  chaiseTests
//
//  Created by Corey Walo on 8/1/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import XCTest
import Moya
@testable import chaise

final class EventSearchViewModelTests: XCTestCase {

    var viewModel: EventSearchViewModel!

    func testInitalViewModelState() {
        let provider = MoyaProvider<SeatGeek>(stubClosure: MoyaProvider.delayedStub(60))
        viewModel = EventSearchViewModel(provider)

        var stateQueue: [SearchState] = []

        viewModel.onStateDidChange = { state in
            stateQueue.append(state)
        }

        let equal = stateQueue.elementsEqual([.initial], by: {
            return $0 == $1
        })

        XCTAssertTrue(equal)
    }

    func testSearchingState() {
        let provider = MoyaProvider<SeatGeek>(stubClosure: MoyaProvider.delayedStub(60))
        viewModel = EventSearchViewModel(provider)

        var stateQueue: [SearchState] = []

        viewModel.onStateDidChange = { state in
            stateQueue.append(state)
        }

        let initialState = stateQueue.first(where: { $0 == .initial })
        XCTAssertNotNil(initialState)

        viewModel.search(for: "SomeTerm")

        let expectedQueue: [SearchState] = [.initial, .searching]

        let equal = stateQueue.elementsEqual(expectedQueue, by: {
            return $0 == $1
        })

        XCTAssertTrue(equal)
    }

    func testSearchingToLoadedState() {
        let provider = MoyaProvider<SeatGeek>(stubClosure: MoyaProvider.immediatelyStub)
        viewModel = EventSearchViewModel(provider)

        var stateQueue: [SearchState] = []

        viewModel.onStateDidChange = { state in
            stateQueue.append(state)
        }

        viewModel.search(for: "SomeTerm")

        delay(1)

        let expectedQueue: [SearchState] = [.initial, .searching, .loaded]

        let equal = stateQueue.elementsEqual(expectedQueue, by: {
            return $0 == $1
        })

        XCTAssertTrue(equal)
    }

    func testLoadingMoreState() {
        let provider = MoyaProvider<SeatGeek>(stubClosure: MoyaProvider.immediatelyStub)
        viewModel = EventSearchViewModel(provider)

        var stateQueue: [SearchState] = []

        viewModel.onStateDidChange = { state in
            stateQueue.append(state)
        }

        viewModel.search(for: "SomeTerm")

        delay(1)

        viewModel.fetchMoreResults()

        delay(1)

        let expectedQueue: [SearchState] = [.initial, .searching, .loaded, .loadingMore, .loaded]

        let equal = stateQueue.elementsEqual(expectedQueue, by: {
            return $0 == $1
        })

        XCTAssertTrue(equal)
    }
}

extension XCTestCase {

    func delay(_ interval: TimeInterval, description: String = "Delayed in test") {
        let e = expectation(description: description)
        DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: { e.fulfill() })
        wait(for: [e], timeout: interval * 1.1)
    }

}
