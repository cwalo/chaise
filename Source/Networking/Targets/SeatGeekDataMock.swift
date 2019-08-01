//
//  SeatGeekDataMock.swift
//  chaise
//
//  Created by Corey Walo on 8/1/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation

enum SeatGeekDataMock {
    static let searchData: Data = {
        guard let path = Bundle.main.path(forResource: "SeatGeekSearch", ofType: "json") else {
            fatalError("SeatGeekSearch.json not found")
        }

        let url = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else {
            fatalError("SeatGeekSearch.json is invalid data")
        }

        return data
    }()
}
