//
//  EventSearchViewModel.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation
import Moya

final class EventSearchViewModel: EventSearching {

    let provider: MoyaProvider<SeatGeek>

    var state: SearchState = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }

    var events: [EventEntity] = []

    var canFetchMore: Bool {
        return events.count < totalEvents
    }

    var onStateDidChange: ((SearchState) -> Void)? {
        didSet {
            state = .initial
        }
    }

    var favoritesManager: FavoritesManager!

    let throttler = Throttler(minimumDelay: 0.2, queue: .global(qos: .userInteractive))

    var searchTerm: String = ""

    var currentPage: Int = 1

    var totalEvents: Int = 0

    init(_ provider: MoyaProvider<SeatGeek>) {
        self.provider = provider

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(EventSearchViewModel.handleFavoritesChangedNotification(_:)),
                                               name: FavoritesManager.FavoritesChangedNotification,
                                               object: nil)
    }

    func search(for term: String) {

        searchTerm = term
        
        let target = SeatGeek.search(term: term, page: 1)

        state = .searching

        let request = {

            self.provider.request(target) { [weak self] result in
                guard let self = self else { return }

                var deferredState: SearchState = self.state
                var deferredEvents: [EventEntity] = []

                defer {
                    DispatchQueue.main.async {
                        self.events = deferredEvents
                        self.state = deferredState
                    }
                }

                switch result {
                case .success(let response):
                    let data = response.data
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(DateFormatter.ISO8601NoZulu())
                        let eventsReponse = try decoder.decode(EventsRemote.self, from: data)
                        self.currentPage = eventsReponse.meta.page
                        self.totalEvents = eventsReponse.meta.total
                        let events = eventsReponse.events
                        deferredEvents = events.map {
                            var entity = EventEntity($0)
                            entity.isFavorite = self.favoritesManager.isFavorite($0.id)
                            return entity
                        }
                        deferredState = .loaded
                    } catch {
                        deferredState = .error(error)
                    }
                case .failure(let error):
                    deferredState = .error(error)
                }
            }
        }

        throttler.throttle {
            _ = request()
        }
    }

    func fetchMoreResults() {
        let target = SeatGeek.search(term: searchTerm, page: currentPage + 1)

        state = .loadingMore

        provider.request(target) { [weak self] result in
            guard let self = self else { return }

            var deferredState: SearchState = self.state
            var deferredEvents: [EventEntity] = []

            defer {
                DispatchQueue.main.async {
                    self.events.append(contentsOf: deferredEvents)
                    self.state = deferredState
                }
            }

            switch result {
            case .success(let response):
                let data = response.data
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.ISO8601NoZulu())
                    let eventsReponse = try decoder.decode(EventsRemote.self, from: data)
                    self.currentPage = eventsReponse.meta.page
                    self.totalEvents = eventsReponse.meta.total
                    let events = eventsReponse.events
                    deferredEvents = events.map {
                        var entity = EventEntity($0)
                        entity.isFavorite = self.favoritesManager.isFavorite($0.id)
                        return entity
                    }
                    deferredState = .loaded
                } catch {
                    deferredState = .error(error)
                }
            case .failure(let error):
                deferredState = .error(error)
            }
        }
    }

    @objc
    func handleFavoritesChangedNotification(_ notification: Notification) {
        let updatedEvents: [EventEntity] = events.map {
            var updatedEntity = $0
            updatedEntity.isFavorite = self.favoritesManager.isFavorite($0.id)
            return updatedEntity
        }

        DispatchQueue.main.async {
            self.events = updatedEvents
            self.state = .loaded
        }
    }
}
