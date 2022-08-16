//
//  Authorization.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
import Combine
protocol AuthorizationManager {
    func accessToken(with : AccessToken) -> AnyPublisher<AccessTokenResponse,Error>
}
