//
//  RepoApi+Moya.swift
//  GitClient
//
//  Created by Mozhgan on 9/24/21.
//

import Foundation
import Moya
extension RepoApi : TargetType,AccessTokenAuthorizable {
    var baseURL: URL {
        return  URL(string: APIServiceConstants.baseURL)!.appendingPathComponent("users")
    }

    var path: String {
        switch self {
        case .getRepos(let params) :
            return "/\(params.username)/repos"
        }
    }

    var method: Moya.Method {
        return Moya.Method.get
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        nil
    }

    var authorizationType: AuthorizationType? {
        .bearer
    }
    var sampleData: Data {
        switch self {
        case .getRepos:
            return (try? ReposResponse.init(fromURL: R.file.reposJson()!).jsonData()) ?? Data()
        }
    }
}
