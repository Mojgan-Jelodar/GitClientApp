//
//  DasboardVCTests.swift
//  GitClientTests
//
//  Created by Mozhgan on 9/26/21.
//

import XCTest
@testable import GitClient

class DasboardVCTests: XCTestCase {

    private var window: UIWindow!
    var userViewModel : Dashboard.UserViewModel!
    var repoViewModel : Dashboard.ReposViewModel!

    // MARK: - Setup / Teardown

    override func setUp() {

        super.setUp()

        window = UIWindow()

       userViewModel = Dashboard.UserViewModel(user: User(id: 123,
                                                          avatarUrl: "",
                                                          username: "Mozhgan",
                                                          name: "Mozhgan",
                                                          email: "jelodar.mozhgan@gmail.com",
                                                          followers: 10,
                                                          following: 5))
        repoViewModel = Dashboard.ReposViewModel(repos: [Repo(id: 1234,
                                                              name: "git client",
                                                              description: nil)])
    }

    override func tearDown() {

        super.tearDown()
        window = nil
        repoViewModel = nil
        userViewModel = nil
    }

    // MARK: - Tests

    func testInitShouldSetViewControllerRouter() {

        // When
        let viewController = DashboardVC()
        // Then
        XCTAssertNotNil(viewController.router)
    }

    func testInitShouldSetViewControllerInteractor() {
        // When
        let viewController = DashboardVC()
        // Then
        XCTAssertNotNil(viewController.interactor)
    }

    func testInitShouldSetInteractorOutput() {

        // When
        let viewController = DashboardVC()
        // Then
        if let interactor = viewController.interactor as? Dashboard.Interactor {
            XCTAssertNotNil(interactor.presenter)

        } else {
            XCTFail("Presenter were empty", file: #file, line: #line)
        }
    }

    func testInitShouldSetPresenterOutput() {

        // When

        let viewController = DashboardVC()

        // Then

        if let interactor = viewController.interactor as? Dashboard.Interactor,
           let presenter = interactor.presenter as? Dashboard.Presenter {

            XCTAssertNotNil(presenter.viewController)

        } else {

            XCTFail("Presenter was empty", file: #file, line: #line)
        }
    }

    func testConfigureShouldSetRouterViewController() {

        // When

        let viewController = DashboardVC()

        // Then

        if let router = viewController.router as? Dashboard.Router {
            XCTAssertEqual(router.viewController, viewController)
        }
    }

    func testViewDidLoadShouldFetchData() {

        // Given

        let viewController = DashboardVC()

        let interactor = DashboardInteractorProtocolSpy()
        viewController.interactor = interactor

        // When
        loadView(window: window, viewController: viewController)
        // Then

        XCTAssertTrue(interactor.fetchUserProfileCalled)
        XCTAssertTrue(interactor.fetchReposCalled)
    }

    func testNumberOfSectionsInTableViewShouldAlwaysBeTwo() {

        // Given
        let viewController = DashboardVC()
        let tableView = viewController.tableView!
        // When
        let numberOfSections = viewController.numberOfSections(in: tableView)
        // Then
        XCTAssertEqual(numberOfSections, 2)
    }

    func testNumberOfRowsInAnySectionShouldEqualNumberOfItemsToDisplay() {

        // Given

        let viewController = DashboardVC()
        let tableView = viewController.tableView!

        viewController.show(viewModel: userViewModel)
        viewController.show(viewModel: repoViewModel)

        // When
        let numberOfFrirstSection = viewController.tableView(tableView, numberOfRowsInSection: 0)
        // Then
        XCTAssertEqual(numberOfFrirstSection, 1)

        // When
        let numberOfSeconfSection = viewController.tableView(tableView, numberOfRowsInSection: 1)
        // Then
        XCTAssertEqual(numberOfSeconfSection, 1)
    }

    func testCellForRowAtIndexShouldConfigureTableViewCellToDisplayProfile() {

        // Given

        let viewController = DashboardVC()
        let tableView = viewController.tableView!

        viewController.show(viewModel: userViewModel)

        // When

        loadView(window: window, viewController: viewController)

        // Then

        let indexPath = IndexPath(row: 0, section: 0)

        if let cell = viewController.tableView(tableView, cellForRowAt: indexPath) as? ProfileTableCell {

            XCTAssertEqual(cell.nameLbl.text, userViewModel.user?.name)

        } else {

            XCTFail("dequeuing profile cell doesn't work")
        }
    }

    func testCellForRowAtIndexShouldConfigureTableViewCellToDisplayRepos() {

        // Given

        let viewController = DashboardVC()
        let tableView = viewController.tableView!

        viewController.show(viewModel: repoViewModel)

        // When

        loadView(window: window, viewController: viewController)

        // Then

        let indexPath = IndexPath(row: 0, section: 1)

        if let cell = viewController.tableView(tableView, cellForRowAt: indexPath) as? RepoTableCell {

            XCTAssertEqual(cell.nameLbl.text, repoViewModel.repos?.first?.name)

        } else {

            XCTFail("dequeueReusableCell doesn't work perfectly")
        }
    }
    func testDidSelectRowAtIndexShouldNavigateToArtist() {

        // Given
        let viewController = DashboardVC()
        let router = DashboardRouterProtocolSpy()
        let tableView = viewController.tableView!
        viewController.router = router
        viewController.show(viewModel: self.repoViewModel)
        // When
        loadView(window: window, viewController: viewController)
        let indexPath = IndexPath(row: 0, section: 0)
        viewController.tableView(tableView, didSelectRowAt: indexPath)
        // Then
        XCTAssertTrue(router.routeToDetail)
    }
}

// MARK: - DashboardInteractor

final class DashboardInteractorProtocolSpy: DashboardBusinessLogic,DashboardDataStore {
    var presenter: DashboardPresentationLogic?
    var repos: [Repo]?
    var fetchUserProfileCalled = false
    var fetchReposCalled = false
    func getUserProfile() {
        fetchUserProfileCalled = true
    }
    func getRepos(username: String) {
        fetchReposCalled = true
    }
}

// MARK: - DashboardRouter
final class DashboardRouterProtocolSpy: DashboardRoutingLogic,DashboardDataPassing {
    var dataStore: DashboardDataStore?
    var routeToDetail = false
    func routeToDetail(index: Int) {
        routeToDetail = true
    }

}
