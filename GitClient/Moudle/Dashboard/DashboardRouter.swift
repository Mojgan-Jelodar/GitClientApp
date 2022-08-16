//
//  DashboardRouter.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
import UIKit
import WebKit
protocol DashboardRoutingLogic {
    func routeToDetail(index : Int)
    func logout()
}
protocol DashboardDataPassing {
    var dataStore : DashboardDataStore? { get }
}
extension Dashboard {
    final class Router : DashboardRoutingLogic,DashboardDataPassing {
        var dataStore: DashboardDataStore?
        weak var viewController : UIViewController?
        init(viewcontroller : UIViewController) {
            self.viewController = viewcontroller
        }
        func routeToDetail(index: Int) {
            // TODO: Route to detail

        }
        func logout() {
            let dataTypes = Set([WKWebsiteDataTypeCookies,
                                 WKWebsiteDataTypeLocalStorage,
                                 WKWebsiteDataTypeSessionStorage,
                                 WKWebsiteDataTypeWebSQLDatabases,
                                 WKWebsiteDataTypeIndexedDBDatabases])
            WKWebsiteDataStore.default().removeData(ofTypes: dataTypes, modifiedSince: Date.distantPast, completionHandler: {
                let vc = Login.Builder.build()
                UserCredintial.shared.logout()
                self.viewController?.view.window?.rootViewController = vc
            })
         }
    }
}
