//
//  DashboardInteractor.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
import Combine

protocol DashboardBusinessLogic {
    func getUserProfile()
    func getRepos(username : String)
}

protocol DashboardDataStore {
    var repos : [Repo]? {get set}
}
extension Dashboard {
    final class Interactor : DashboardBusinessLogic,DashboardDataStore {
        var repos: [Repo]?

        private(set) var userManager : UserManager?
        private(set) var repoManager : RepoManager?
        private(set) var presenter : DashboardPresentationLogic?

        private var subscriber = Set<AnyCancellable>()

        init(userManager : UserManager?,
             repoManager : RepoManager?,
             presenter : DashboardPresentationLogic?) {
            self.presenter = presenter
            self.userManager = userManager
            self.repoManager = repoManager
        }

        func getUserProfile() {
            userManager?.getProfile()
                .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.presenter?.fetched(user: .failure(error: error))
                }

            }, receiveValue: { [weak self] response in
                self?.getRepos(username: response.login ?? "")
                self?.presenter?.fetched(user: .success(value: response))
            }).store(in: &subscriber)

        }
        internal func getRepos(username : String) {
            repoManager?.getRepos(params: RepoRequest(username: username))
                .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.presenter?.fetched(repos: .failure(error: error))
                }
            }, receiveValue: { [weak self] response in
                self?.repos = response.map({Repo(object: $0)})
                self?.presenter?.fetched(repos: .success(value: response))
            }).store(in: &subscriber)
        }
    }

}
