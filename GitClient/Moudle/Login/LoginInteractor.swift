//
//  LoginInteractor.swift
//  GitClient
//
//  Created by Mozhgan on 9/25/21.
//

import Foundation
import Combine
protocol LoginDataStore {
    var accessToken : String? {get set}
}
protocol LoginBusinessLogic {
    func requestForAccessToken(code : String)
}
extension Login {

    final class Interactor : LoginBusinessLogic,LoginDataStore {
        var accessToken: String?
        let serviceManager : AuthorizationManager
        let presenter : LoginPresentationLogic?
        private var subscriber = Set<AnyCancellable>()

        init(serviceManager : AuthorizationManager,
             presenter : LoginPresentationLogic) {
            self.serviceManager = serviceManager
            self.presenter = presenter
        }
        func requestForAccessToken(code: String) {
            serviceManager.accessToken(with: AccessToken(grantType: "authorization_code", code: code)).sink(receiveCompletion: {[weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.presenter?.fetched(accessToken: .failure(error: error))
                }
            }, receiveValue: {[weak self] response in
                GitHubCredintial.shared.accessToken = response.asccessToken
                self?.accessToken = response.asccessToken
                self?.presenter?.fetched(accessToken: .success(value: response))
                NotificationCenter.default.post(name: .isAuthorized, object: nil)
            }).store(in: &subscriber)
        }
    }
}
