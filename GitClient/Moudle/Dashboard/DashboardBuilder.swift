//
//  DashboardProtocols.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
extension Dashboard {
    struct Builder : SceneBuilder {
        typealias Output = DashboardVC
        typealias Input = String

        static func build(with : String) -> DashboardVC {
            let vc  = DashboardVC()
            let presenter = Dashboard.Presenter()
            presenter.viewController = vc
            let interactor = Dashboard.Interactor(userManager: MoyaUserManager(),
                                                  repoManager: MoyaRepoManager(),
                                                  presenter: presenter)

            let router = Dashboard.Router(viewcontroller: vc)
            router.dataStore = interactor
            vc.interactor = interactor
            vc.router = router
            return vc

        }

    }
}
