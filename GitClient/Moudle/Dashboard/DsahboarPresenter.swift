//
//  DsahboarPresenter.swift
//  GitClient
//
//  Created by Mozhgan on 9/24/21.
//

import Foundation
enum ServiceResult<T : Codable> {
    case success(value : T)
    case failure(error : Error)
}
enum RepoServiceResult<T : Codable> {
    case success(value : [T])
    case failure(error : Error)
}
protocol  DashboardPresentationLogic : AnyObject {
    func fetched(user: ServiceResult<UserResponse>)
    func fetched(repos : RepoServiceResult<RepoResponse>)
}

protocol DashboardDisplayLogic : AnyObject {
    func show(viewModel : Dashboard.ErrorViewModel)
    func show(viewModel : Dashboard.UserViewModel)
    func show(viewModel : Dashboard.ReposViewModel)
}

extension Dashboard {

    final class Presenter : DashboardPresentationLogic {

        weak var viewController: DashboardDisplayLogic?

        func fetched(user: ServiceResult<UserResponse>) {
            switch user {
            case .success(let value):
                viewController?.show(viewModel: Dashboard.UserViewModel(user: User(object: value)))
            case .failure(let error):
                viewController?.show(viewModel: Dashboard.ErrorViewModel(title: R.string.shared.errorDialogTitle(),
                                                                     message: error.localizedDescription,
                                                                     buttonTitles: [R.string.shared.errorDialogButtonTitle()]))
            }

        }

        func fetched(repos : RepoServiceResult<RepoResponse>) {
            switch repos {
            case .success(let value):
                viewController?.show(viewModel: Dashboard.ReposViewModel(repos: value.map(Repo.init(object:)) ))
            case .failure(let error):
                viewController?.show(viewModel: Dashboard.ErrorViewModel(title: R.string.shared.errorDialogTitle(),
                                                                     message: error.localizedDescription,
                                                                     buttonTitles: [R.string.shared.errorDialogButtonTitle()]))
            }
        }

    }

}
