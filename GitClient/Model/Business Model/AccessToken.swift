//
//  AccessToken.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
struct AccessToken {
    let grantType : String
    let code : String
    private let clientId : String = GithubConstants.clientId
    private let clientSecret : String = GithubConstants.clienrSecret
}

extension AccessToken : ModelMappable {
    func wsModel() -> AccessTokenRequest {
        AccessTokenRequest(grantType: grantType, code: code, clientId: clientId, clientSecret: clientSecret)
    }
}
