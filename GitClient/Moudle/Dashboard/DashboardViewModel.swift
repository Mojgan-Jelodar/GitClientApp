//
//  DashboardViewModel.swift
//  GitClient
//
//  Created by Mozhgan on 9/24/21.
//

import Foundation
extension Dashboard {
    struct ReposViewModel {
        let repos : [Repo]?
    }
    struct ErrorViewModel {
        let title: String?
        let message: String?
        let buttonTitles: [String]?
    }

    struct UserViewModel {
        let user : User?
    }
}
