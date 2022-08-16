//
//  LoginPresenter.swift
//  GitClient
//
//  Created by Mozhgan on 9/25/21.
//

import Foundation
protocol  LoginPresentationLogic : AnyObject {
    func fetched(accessToken: ServiceResult<AccessTokenResponse>)
}

protocol LoginDisplayLogic : AnyObject {
    func show(viewModel : Login.ErrorViewModel)
    func fetched()
}

extension Login {
    final class Presenter  : LoginPresentationLogic {
        weak var viewcontroller : LoginDisplayLogic?

        func fetched(accessToken: ServiceResult<AccessTokenResponse>) {
            switch accessToken {
            case .failure(let error):
                viewcontroller?.show(viewModel: Login.ErrorViewModel(title: R.string.shared.errorDialogTitle(),
                                                                     message: error.localizedDescription,
                                                                     buttonTitles:[R.string.shared.errorDialogButtonTitle()]))
            case .success:
                viewcontroller?.fetched()
            }
        }
    }
}
