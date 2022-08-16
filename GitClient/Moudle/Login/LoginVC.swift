//
//  LoginViewController.swift
//  GitClient
//
//  Created by Mozhgan on 9/25/21.
//

import UIKit
import WebKit
import SnapKit

class LoginVC: UIViewController {
    var router : (LoginRouterDataPassing & LoginRouterLogic)?
    var interactor : (LoginBusinessLogic & LoginDataStore)?
    private lazy var webView : WKWebView = {
        let tmp = WKWebView()
        tmp.navigationDelegate = self
        tmp.allowsBackForwardNavigationGestures = false
        tmp.translatesAutoresizingMaskIntoConstraints = false
        return tmp
    }()
    var urlRequest : URL? {
        didSet {
            self.webView.load(URLRequest(url: urlRequest!))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func loadView() {
        super.loadView()
        func setupWebview() {
            self.view.addSubview(webView)
            webView.snp.makeConstraints { maker in
                maker.edges.equalToSuperview()
            }
        }
        setupWebview()
    }
}
extension LoginVC : LoginDisplayLogic {
    func show(viewModel: Login.ErrorViewModel) {
        self.showAlert(withTitle: viewModel.title ?? "",
                       withMessage: viewModel.message ?? "",
                       buttonTitle: viewModel.buttonTitles?.first ?? "")
    }
    func fetched() {
        router?.navigateToDashboard()
    }
}

// MARK: delegate
extension LoginVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // here we handle internally the callback url and call method that call handleOpenURL (not app scheme used)
        if let url = navigationAction.request.url ,  GithubConstants.redirectUri.contains(url.scheme ?? "") {
            UIViewController.sceneDelegate?.handleDeepLinkUrl(url)
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.showAlert(withTitle: R.string.shared.errorDialogTitle(),
                       withMessage: error.localizedDescription,
                       buttonTitle: R.string.shared.errorDialogButtonTitle())
    }
}
