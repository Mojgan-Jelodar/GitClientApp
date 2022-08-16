//
//  LoginBuilder.swift
//  GitClient
//
//  Created by Mozhgan on 9/22/21.
//

import Foundation
import SafariServices

protocol SceneBuilder {
    associatedtype Output
    associatedtype Input
    static func build(with : Input) -> Output
}
extension SceneBuilder where Input == Void {

    static func build() -> Output {
        return Self.build(with: ())
    }

}

extension Login {
    struct Builder : SceneBuilder {
        typealias Output = LoginVC
        typealias Input = Void

        static func build(with : Input) -> LoginVC {
            var path = APIServiceConstants.gitHubBaseUrl + "login/oauth/authorize"
            let queryParamEncoder = QueryParamCodable<AuthorizeRequest>()
            path.append((try? queryParamEncoder.encode(AuthorizeRequest())) ?? "")
            let vc = LoginVC()
            vc.urlRequest = URL(string: path)!
            let presenter = Login.Presenter()
            presenter.viewcontroller = vc
            let interactor = Login.Interactor(serviceManager: MoyaAuthorizationManager(),
                                              presenter: presenter)
            let router = Login.Router(viewController: vc)
            router.store = interactor
            vc.interactor = interactor
            vc.router = router
            return vc
        }
    }

}
