//
//  UIViewController+Delegate.swift
//  GitClient
//
//  Created by Mozhgan on 9/25/21.
//

import Foundation
import UIKit

extension UIViewController {

  class var sceneDelegate: SceneDelegate? {
     guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
         let delegate = windowScene.delegate as? SceneDelegate else { return nil }
      return delegate
 }
}

extension UIViewController {
  class var window: UIWindow? {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
           return window
 }
}
