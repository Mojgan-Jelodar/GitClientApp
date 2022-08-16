//
//  MoyaUser.swift
//  GitClient
//
//  Created by Mozhgan on 9/25/21.
//

import Foundation
import Combine
import Moya

struct MoyaUserManager : UserManager {
    func getProfile() -> AnyPublisher<UserResponse, Error> {
        MoyaCombineNetworkExecuter
            .shared
            .makeNetworkRequestForAPIService(service:MultiTarget(UserApi.getProfile),
                                             networkProvider: sharedNetworkProvider)
            .decode(type: UserResponse.self, decoder: JSONDecoder()).eraseToAnyPublisher()
    }
}
