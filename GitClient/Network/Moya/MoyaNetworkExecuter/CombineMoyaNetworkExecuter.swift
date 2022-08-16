//
//  File.swift
//
//  Created by Mozhgan on 8/30/21.
//

import Foundation
import Moya
import Combine
import SwiftUI

struct MoyaCombineNetworkExecuter : Loggable {

    static let shared = MoyaCombineNetworkExecuter()
    let authenticator = AppAuthenticator(loginView: AppReloginHandler())
    private static var configuartion : MoyaCombineNetworkExecuter.Configuartion?

    var logger: Logger?

    func makeNetworkRequestForAPIService(service: TargetType, networkProvider: MoyaProvider<MultiTarget>) -> AnyPublisher<Data, Error> {
        return networkProvider.requestPublisher(MultiTarget(service))
            .share()
            .catch { error -> AnyPublisher<Result<Response, Error>, Error> in
            let statusCode : HTTPStatusCode = (error.response?.response?.status ?? .ok)
            self.logger?.trace(request: error.response?.request , error: error)
            switch statusCode {
            case .serviceUnavailable,.tooManyRequests :
                return Fail(error: error)
                      .delay(for: 3, scheduler: DispatchQueue.global())
                      .eraseToAnyPublisher()
            case .unauthorized :
                authenticator.sessionIsExpired()
                return Empty().eraseToAnyPublisher()
            default:
                return Just(Result.failure(error))
                      .setFailureType(to: Error.self)
                      .eraseToAnyPublisher()

            }
        }
            .retry(2)
            .tryMap({ result in
            let response = try result.get().response
            let data = try result.get().data
            self.logger?.trace(response: response!, data: data)
            return try result.get().data
        }).eraseToAnyPublisher()

    }

    init() {
        self.logger = MoyaCombineNetworkExecuter.configuartion?.logger
    }
}

extension MoyaCombineNetworkExecuter {
    static func setup(configuartion : Configuartion) {
        MoyaCombineNetworkExecuter.configuartion = configuartion
    }
}

extension MoyaCombineNetworkExecuter {
    struct Configuartion {
        let logger: Logger?
    }
}
