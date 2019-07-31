//
//  MockEventSearchViewModel.swift
//  chaise
//
//  Created by Corey Walo on 7/31/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation

final class MockEventSearchViewModel: EventSearching {

    var state: SearchState = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }

    var events: [EventEntity] = []

    var canFetchMore: Bool {
        return events.count < 50
    }

    // by setting the initial state after this closure is set,
    // we can assume the owner of the instance is ready to handle any changes
    var onStateDidChange: ((SearchState) -> Void)? {
        didSet {
            state = .initial
        }
    }


    func search(for term: String) {
        state = .searching

        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.2) {
            var results: [EventEntity] = []

            for _ in 0...10 {
                let event = EventEntity.mock
                results.append(event)
            }

            self.events = results
            self.state = .loaded
        }
    }

    func fetchMoreResults() {

        state = .loadingMore

        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.2) {
            var results: [EventEntity] = []

            for _ in 0...10 {
                let event = EventEntity.mock
                results.append(event)
            }

            self.events.append(contentsOf: results)
            self.state = .loaded
        }
    }
}
