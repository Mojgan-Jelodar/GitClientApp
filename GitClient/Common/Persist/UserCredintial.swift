//
//  File.swift
//  GitClient
//
//  Created by Mozhgan on 10/6/21.
//

import Foundation
final class UserCredintial {
    static let shared = UserCredintial()

    private let keyChainTokenManager = KeyChainTokenCaretaker()
    var accessToken : String? {
        didSet {
            guard let value = accessToken else {
                return
            }
            try? keyChainTokenManager.save(data: TokenMomento(accessToken: value))
        }
    }
    private init() {
      self.accessToken = try? keyChainTokenManager.load()?.accessToken ?? nil
    }
    func logout() {
        try? self.keyChainTokenManager.removeValue()
    }
}
