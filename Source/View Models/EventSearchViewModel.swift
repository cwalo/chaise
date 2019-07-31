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
