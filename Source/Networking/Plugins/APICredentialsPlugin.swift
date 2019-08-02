//
//  APICredentialsPlugin.swift
//  chaise
//
//  Created by Corey Walo on 7/31/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation
import Moya

/**
 APICredentialsPlugin is used to inject API credentials at the time of the request. You should add it as a plugin when creating a MoyaProvider, passing a closure returning a Dictionary of [String: String]
*/
struct APICredentialsPlugin: PluginType {

    typealias CredentialsClosure = () -> [String: String]

    var credentials: CredentialsClosure

    init(credentials: @escaping CredentialsClosure) {
        self.credentials = credentials
    }

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {

        guard let modifiedURL = request.url?.appendingQueryItems(credentials()) else { return request }
        var request = request
        request.url = modifiedURL
        return request
    }
}
