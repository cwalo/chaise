//
//  EventSearching.swift
//  chaise
//
//  Created by Corey Walo on 7/31/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation

enum SearchState {
    case initial
    case searching
    case loadingMore
    case loaded
    case error(Error)
}

extension SearchState: Equatable {

    static func == (lhs: SearchState, rhs: SearchState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case (.searching, .searching):
            return true
        case (.loadingMore, .loadingMore):
            return true
        case (.loaded, .loaded):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}

protocol EventSearching: AnyObject {
    var state: SearchState { get set }
    var events: [EventEntity] { get set }
    var canFetchMore: Bool { get }
    var onStateDidChange: ((SearchState) -> Void)? { get set }
    func search(for term: String)
    func fetchMoreResults()
}
