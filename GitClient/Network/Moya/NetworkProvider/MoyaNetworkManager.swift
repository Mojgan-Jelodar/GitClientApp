//
//  MoyaNetworkManager.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
import Moya
final class GitHubCredintial {
    static let shared = GitHubCredintial()

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
}

let sharedMockNetworkProvider = MoyaProvider<MultiTarget>(
    stubClosure: MoyaProvider.immediatelyStub
)

let sharedNetworkProvider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)),
                                                                    AccessTokenPlugin {_ in
                                                                        GitHubCredintial.shared.accessToken ?? ""
                                                                    },
                                                                    HeaderPlugin()])
