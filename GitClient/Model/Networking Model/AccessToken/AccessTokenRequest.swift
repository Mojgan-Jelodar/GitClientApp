//
//  AccessTokenRequest.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
struct AccessTokenRequest : Codable {
    let grantType : String
    let code : String
    let clientId : String
    let clientSecret : String

    enum CodingKeys : String,CodingKey {
        case grantType = "grant_type"
        case code
        case clientId = "client_id"
        case clientSecret = "client_secret"
    }

}
