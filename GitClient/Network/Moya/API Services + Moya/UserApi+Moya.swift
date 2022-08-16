//
//  UserApi+Moya.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
import Moya
extension UserApi : TargetType,AccessTokenAuthorizable {
    var baseURL: URL {
        return URL(string: APIServiceConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .getProfile:
            return "user"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getProfile:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getProfile:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return nil
    }
    var sampleData: Data {
        switch self {
        case .getProfile:
            return (try? UserResponse.init(fromURL: R.file.userJson()!).jsonData()) ?? Data()
        }
    }

    var authorizationType: AuthorizationType? {
        return .bearer
    }

}
