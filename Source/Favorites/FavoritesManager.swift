//
//  FavoritesManager.swift
//  chaise
//
//  Created by Corey Walo on 8/1/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation
import UIKit

struct Favorite: Codable {
    let id: Int
}

final class FavoritesManager: JSONFileStoring {

    static let FavoritesChangedNotification = Notification.Name(rawValue: "FavoritesChangedNotification")

    static let FavoritesFile = "SeakGeekFavorites"

    private (set) var favorites: [Favorite] = [] {
        didSet {
            NotificationCenter.default.post(name: FavoritesManager.FavoritesChangedNotification, object: nil)
        }
    }

    deinit {
        writeFavoritesToDisk()
    }

    init() {
        do {
            favorites = try get(type: [Favorite].self, from: FavoritesManager.FavoritesFile)
        } catch {
            favorites = []
        }

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(FavoritesManager.writeFavoritesToDisk),
                                               name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    func favorite(_ id: Int) {
        if favorites.contains(where: { $0.id == id }) { return }
        favorites.append(Favorite(id: id))
    }

    func unfavorite(_ id: Int) {
        guard let index = favorites.firstIndex(where: { $0.id == id }) else { return }
        favorites.remove(at: index)
    }

    func isFavorite(_ id: Int) -> Bool {
        return favorites.contains(where: { $0.id == id })
    }

    @objc
    private func writeFavoritesToDisk() {
        do {
            try write(data: favorites, to: FavoritesManager.FavoritesFile)
        } catch {
            print(error)
        }
    }
}
