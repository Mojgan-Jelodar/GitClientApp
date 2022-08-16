//
//  Authorize.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
struct AuthorizeRequest : Codable {
    let clientId : String
    let secretKey : String
    let scope : String
    let redirectUri : String
    let state : String
    let responseType : String

    enum CodingKeys : String,CodingKey {
        case clientId =  "client_id"
        case secretKey =  "String"
        case scope = "scope"
        case redirectUri = "redirect_uri"
        case state = "state"
        case responseType = "response_type"
    }

    init(clientId : String = GithubConstants.clientId,
         secretKey : String = GithubConstants.clienrSecret,
         scope : String = GithubConstants.scope,
         redirectUri : String = GithubConstants.redirectUri,
         state : String = UUID().uuidString,
         responseType : String = GithubConstants.responseType) {
        self.clientId = clientId
        self.secretKey = secretKey
        self.scope = scope
        self.redirectUri = redirectUri
        self.state = state
        self.responseType = responseType
    }
}
