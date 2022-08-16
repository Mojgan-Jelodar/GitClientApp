//
//  DeepLinkData.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
import Combine

extension URL {
 func valueOf(_ queryParamaterName: String) -> String? {
    guard let url = URLComponents(string: self.absoluteString) else { return nil }
    return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value?.removingPercentEncoding?.removingPercentEncoding
 }
}

extension SceneDelegate {
    func handleDeepLinkUrl(_ url: URL?) {
     guard let url = url else {return}
     if let code = url.valueOf("code"),
        let loginVC = self.window?.rootViewController as? LoginVC {
            loginVC.interactor?.requestForAccessToken(code: code)
        }
    }
}
