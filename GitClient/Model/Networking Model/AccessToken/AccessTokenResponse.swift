//
//  AccessTokenResponse.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
struct AccessTokenResponse : Codable {
    var asccessToken : String
    var tokenType : String
    var scope : String

    enum CodingKeys : String,CodingKey {
        case asccessToken = "access_token"
        case tokenType = "token_type"
        case scope = "scope"
    }
}
