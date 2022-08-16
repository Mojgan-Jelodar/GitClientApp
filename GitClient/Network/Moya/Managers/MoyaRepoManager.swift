//
//  File.swift
//  GitClient
//
//  Created by Mozhgan on 9/25/21.
//

import Foundation
import Combine
import Moya

struct MoyaRepoManager : RepoManager {
    func getRepos(params : RepoRequest) -> AnyPublisher<[RepoResponse], Error> {
        MoyaCombineNetworkExecuter
            .shared
            .makeNetworkRequestForAPIService(service:MultiTarget(RepoApi.getRepos(params: params)),
                                             networkProvider: sharedNetworkProvider)
            .decode(type: [RepoResponse].self, decoder: JSONDecoder()).eraseToAnyPublisher()
    }

//    func getRepoDetail(param: Repo) -> AnyPublisher<RepoDetailResponse, Error> {
//        <#code#>
//    }

}
