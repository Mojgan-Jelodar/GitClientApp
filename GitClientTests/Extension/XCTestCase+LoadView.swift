//
//  File.swift
//  GitClientTests
//
//  Created by Mozhgan on 9/26/21.
//

import XCTest

extension XCTestCase {

    // MARK: - Load view

    func loadView(window: UIWindow, viewController: UIViewController) {

        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
}
