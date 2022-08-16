//
//  UserAPIService+Moya.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
import Moya
extension AuthorizationApi : TargetType {
    var baseURL: URL {
        return URL(string: APIServiceConstants.gitHubBaseUrl)!.appendingPathComponent("login/oauth/")
    }

    var path: String {
        switch self {
        case .accessToken:
            return "access_token"
        }
    }

    var method: Moya.Method {
        switch self {
        case .accessToken:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .accessToken(let params):
            let paramCodable = QueryParamCodable<AccessTokenRequest>()
            // swiftlint:disable force_try
            var queryString = try! paramCodable.encode(params)
            // swiftlint:enable force_try
            queryString = queryString.replacingOccurrences(of: "?", with: "")
            return .requestData(queryString.data(using: String.Encoding.utf8) ?? Data() )
        }
    }

    var headers: [String : String]? {
        return ["Accept" : "application/json"]
    }
}
