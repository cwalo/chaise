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

protocol EventSearching: AnyObject {
    var state: SearchState { get set }
    var events: [EventEntity] { get set }
    var canFetchMore: Bool { get }
    var onStateDidChange: ((SearchState) -> Void)? { get set }
    func search(for term: String)
    func fetchMoreResults()
}
