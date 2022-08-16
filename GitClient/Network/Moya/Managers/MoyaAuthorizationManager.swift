//
//  MoyaAuthorizationManager.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
import Combine
import Moya

struct MoyaAuthorizationManager : AuthorizationManager {
    func accessToken(with: AccessToken) -> AnyPublisher<AccessTokenResponse, Error> {
        MoyaCombineNetworkExecuter
            .shared
            .makeNetworkRequestForAPIService(service:MultiTarget(AuthorizationApi.accessToken(params: with.wsModel())),
                                             networkProvider: sharedNetworkProvider)
            .decode(type: AccessTokenResponse.self, decoder: JSONDecoder()).eraseToAnyPublisher()
    }

}
