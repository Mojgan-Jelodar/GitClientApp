//
//  LoginRouter.swift
//  GitClient
//
//  Created by Mozhgan on 9/22/21.
//

import Foundation
import UIKit
enum Login {
}
protocol LoginRouterLogic: AnyObject {
    func navigateToDashboard()
}
protocol LoginRouterDataPassing {
    var store : LoginDataStore? { get }
}

extension Login {
    final class Router : LoginRouterLogic,LoginRouterDataPassing {
        var store: LoginDataStore?
        weak var viewController: UIViewController?
        init(viewController: UIViewController) {
            self.viewController = viewController
        }
        func navigateToDashboard() {
            let vc = Dashboard.Builder.build(with: store?.accessToken ?? "")
            viewController?.view?.window?.rootViewController = UINavigationController(rootViewController: vc)
            viewController?.view?.window?.makeKeyAndVisible()
        }
    }
}
