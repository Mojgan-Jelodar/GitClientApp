//
//  Repo.swift
//  GitClient
//
//  Created by Mozhgan on 9/24/21.
//

import Foundation
struct Repo {
    let id : Int
    let name : String
    let description : String?
}

extension Repo : ModelMapping {
    typealias S = RepoResponse
    init(object: RepoResponse) {
        self.init(id: object.id ?? 0,
                  name: object.name ?? "-",
                  description: object.repoDescription ?? "")
    }
}
