//
//  FavoriteManagerTests.swift
//  chaiseTests
//
//  Created by Corey Walo on 8/1/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import XCTest
@testable import chaise

final class FavoriteManagerTests: XCTestCase {

    func testFavoriteAdded() {
        let manager = FavoritesManager()
        manager.favorite(1)
        XCTAssertTrue(manager.favorites.contains(where: {$0.id == 1 }))
    }

    func testFavoriteRemoved() {
        let manager = FavoritesManager()
        manager.favorite(1)
        manager.unfavorite(1)
        XCTAssertFalse(manager.favorites.contains(where: {$0.id == 1 }))
    }

    func testFavoriteIsFavorite() {
        let manager = FavoritesManager()
        manager.favorite(1)
        XCTAssertTrue(manager.isFavorite(1))
    }
}
