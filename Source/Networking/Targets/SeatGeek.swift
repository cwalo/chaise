//
//  SeatGeek.swift
//  chaise
//
//  Created by Corey Walo on 7/31/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation
import Moya

/**
 SeatGeek TargetType describes the SeatGeek API interface, endpoints, methods, and parameters. It is used as a parameter when making a request with a MoyaProvider.
*/
enum SeatGeek: TargetType {

    case search(term: String, page: Int)

    var baseURL: URL {
        return URL(string: "https://api.seatgeek.com/2")!
    }

    var path: String {
        switch self {
        case .search: return "/events"
        }
    }

    var method: Moya.Method {
        switch self {
        case .search: return .get
        }
    }

    var task: Task {
        switch self {
        case .search(let term, let page):
            let encodedTerm = term.replacingOccurrences(of: " ", with: "+")
            let parameters: [String: Any] = ["q": encodedTerm,
                                             "page": page]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.methodDependent)
        }
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var headers: [String : String]? {
        return nil
    }

    var sampleData: Data {
        return SeatGeekDataMock.searchData
    }

}
