//
//  File.swift
//  GitClient
//
//  Created by Mozhgan on 9/22/21.
//

import Foundation
struct GithubConstants {
    static let clientId = "7585078a1d8e1607ad8e"
    static let clienrSecret = "437467bfda2578e17cad27749973da2895f22fee"
    static let scope = "read:user,user:email,read:repo"
    static let redirectUri = "githubclient://oauth-callback"
    static let responseType = "code"
}
