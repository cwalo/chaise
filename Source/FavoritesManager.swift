//
//  FavoritesManager.swift
//  chaise
//
//  Created by Corey Walo on 8/1/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation
import UIKit

protocol JSONFileStoring {
    func write<T: Codable>(data: T, to fileNamed: String) throws
    func get<T: Codable>(type: T.Type, from fileNamed: String) throws -> T
}

extension JSONFileStoring {
    func write<T: Codable>(data: T, to fileNamed: String) throws {
        let libraryDirectory = try FileManager.default.url(for: .libraryDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: true)

        let path = libraryDirectory.appendingPathComponent("\(fileNamed).json")

        createFileIfNeeded(at: path.absoluteString)

        let json = try JSONEncoder().encode(data)
        try json.write(to: path)
    }

    func get<T: Codable>(type: T.Type, from fileNamed: String) throws -> T {
        let libraryDirectory = try FileManager.default.url(for: .libraryDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: true)

        let path = libraryDirectory.appendingPathComponent("\(fileNamed).json")
        let json = try Data(contentsOf: path)
        return try JSONDecoder().decode(T.self, from: json)
    }

    func createFileIfNeeded(at path: String) {
        guard !FileManager.default.fileExists(atPath: path) else { return }
        FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
    }
}

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
