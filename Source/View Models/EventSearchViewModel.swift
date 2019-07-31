//
//  EventSearchViewModel.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation


final class EventSearchViewModel: EventSearching {

    var state: SearchState = .initial

    var events: [EventEntity] = []

    var canFetchMore: Bool {
        return false
    }

    var onStateDidChange: ((SearchState) -> Void)?

    func search(for term: String) {

    }

    func fetchMoreResults() {

    }
}

final class MockEventSearchViewModel: EventSearching {

    var state: SearchState = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }

    var events: [EventEntity] = []

    var canFetchMore: Bool {
        return true
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
                let event = self.createMockEvent()
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
                let event = self.createMockEvent()
                results.append(event)
            }

            self.events = results
            self.state = .loaded
        }
    }

    private func createMockEvent() -> EventEntity {
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
    }

}
