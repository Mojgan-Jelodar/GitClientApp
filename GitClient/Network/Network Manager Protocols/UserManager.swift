//
//  UserManager.swift
//  GitClient
//
//  Created by Mozhgan on 9/24/21.
//

import Foundation
import Combine
protocol UserManager {
    func getProfile() -> AnyPublisher<UserResponse,Error>
}
