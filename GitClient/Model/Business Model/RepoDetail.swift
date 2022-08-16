//
//  RepoDetail.swift
//  GitClient
//
//  Created by Mozhgan on 9/24/21.
//

import Foundation
struct RepositoryDetail {

}
extension RepositoryDetail : ModelMapping {
    typealias S = RepoDetailResponse
    init(object: RepoDetailResponse) {
        self.init()
    }
}
