//
//  DashboardInteractorTests.swift
//  GitClientTests
//
//  Created by Mozhgan on 9/26/21.
//

import XCTest
import Moya
import Combine

@testable import GitClient

class DashboardInteractorTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    // MARK: - Tests
    func testFetchUserShouldAskWorkerToFetch() {

        // Given
        let userWorkerSpy = UserWorkerSpy()
        let presenterSpy = DasboardPresenterSpy()
        let interactor = Dashboard.Interactor(userManager: userWorkerSpy,
                                              repoManager: nil,
                                              presenter: presenterSpy)

        // When
        interactor.getUserProfile()
        // Then
        XCTAssertTrue(userWorkerSpy.fetchUserCalled)
    }
    // MARK: - Tests
    func testFetchReposShouldAskWorkersToFetch() {

        // Given
        let reposWorkerSpy = ReposWorkerSpy()
        let presenterSpy = DasboardPresenterSpy()
        let interactor = Dashboard.Interactor(userManager: nil,
                                              repoManager: reposWorkerSpy,
                                              presenter: presenterSpy)

        // When
        interactor.getRepos(username: Seeds.Repo.name)
        // Then
        XCTAssertTrue(reposWorkerSpy.fetchReposCalled)
    }
}

class DasboardPresenterSpy : DashboardPresentationLogic {
    var presentErrorCalled = false
    var presentUserCalled = false
    var presentRepoCalled = false
    func fetched(user: ServiceResult<UserResponse>) {
        switch user {
        case .failure:
            presentErrorCalled = true
        default:
            presentUserCalled = true
        }
    }
    func fetched(repos: RepoServiceResult<RepoResponse>) {
        switch repos {
        case .failure:
            presentErrorCalled = true
        default:
            presentRepoCalled = true
        }
    }
}
final class ReposWorkerSpy: RepoManager {
    var fetchReposCalled = false
    var fetchRepoError = false
    func getRepos(params: RepoRequest) -> AnyPublisher<ReposResponse,Error> {
        fetchReposCalled = true
        if fetchRepoError {
            return Fail(error: MoyaError.requestMapping("")).eraseToAnyPublisher()
        }
        return Empty().eraseToAnyPublisher()
    }
}

final class UserWorkerSpy: UserManager {

    var fetchUserCalled = false

    var fetchUserError = false
    func getProfile() -> AnyPublisher<UserResponse, Error> {
        fetchUserCalled = true
        if fetchUserError {
            return Fail(error: MoyaError.requestMapping("")).eraseToAnyPublisher()
        }
        return Empty().eraseToAnyPublisher()
    }
}
