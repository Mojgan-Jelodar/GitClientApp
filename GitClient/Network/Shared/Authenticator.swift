//
//  File.swift
//
//  Created by Mozhgan on 9/12/21.
//

import Foundation
import UIKit
import Combine

extension Notification.Name {
    public static var isAuthorized : Notification.Name {
        return .init(rawValue: "UserSession.isAuthorized")
    }
}

protocol ReloginView {
    func present()
}

struct AppReloginHandler: ReloginView {
    func present() {
        let vc = Login.Builder.build()
        UIViewController.window?.rootViewController = vc
        UIViewController.window?.makeKeyAndVisible()
    }
}

protocol Authenticator {
    func sessionIsExpired()
}

final class AppAuthenticator : Authenticator {

    private var isAuthorizing = false
    private var loginView : ReloginView
    private var cancellable: AnyCancellable?

    init(loginView : ReloginView) {
        self.loginView = loginView
        cancellable = NotificationCenter.Publisher(center: .default, name: .isAuthorized, object: nil)
            .subscribe(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.isAuthorizing = false
            })
    }
    func sessionIsExpired() {
        guard !isAuthorizing else {
            return
        }
        isAuthorizing = true
        self.loginView.present()
    }
}
