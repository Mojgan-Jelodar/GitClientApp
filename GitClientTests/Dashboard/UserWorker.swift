//
//  DashboardWorkerSpec.swift
//  GitClientTests
//
//  Created by Mozhgan on 9/26/21.
//

import Combine
import Moya
import XCTest

@testable import GitClient
class DashboardWorkerTests : XCTestCase {
    var describer : Set<AnyCancellable>!

    override  func setUp() {
        super.setUp()
        describer = Set<AnyCancellable>()
    }
    override  func tearDown() {
        super.tearDown()
        describer = nil
    }

    func testFetchUserFromNetwork() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch User Profile")
        let worker = UserManagerSpy()
        worker.getProfile().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }, receiveValue: { response in
            XCTAssertNotNil(response, "No user was exsist.")
            expectation.fulfill()
        }).store(in: &describer)
        wait(for: [expectation], timeout: 10.0)

    }

    func testFetchReposFromNetwork() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch User's Repos")
        // When
        let worker = RepoManagerSpy()

        worker.getRepos(params: RepoRequest(username: Seeds.User.login))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                    expectation.fulfill()
                }
            }, receiveValue: { response in
                XCTAssertNotNil(response, "No repo was exsist.")
                expectation.fulfill()
            }).store(in: &describer)
            wait(for: [expectation], timeout: 10.0)
    }
}

class UserManagerSpy : UserManager {
    func getProfile() -> AnyPublisher<UserResponse, Error> {
        MoyaCombineNetworkExecuter
            .shared
            .makeNetworkRequestForAPIService(service:MultiTarget(UserApi.getProfile),
                                             networkProvider: sharedMockNetworkProvider)
            .decode(type: UserResponse.self, decoder: JSONDecoder()).eraseToAnyPublisher()
    }
}
class RepoManagerSpy : RepoManager {
    func getRepos(params: RepoRequest) -> AnyPublisher<[RepoResponse], Error> {
        MoyaCombineNetworkExecuter
            .shared
            .makeNetworkRequestForAPIService(service:MultiTarget(RepoApi.getRepos(params: params)),
                                             networkProvider: sharedMockNetworkProvider)
            .decode(type: ReposResponse.self, decoder: JSONDecoder()).eraseToAnyPublisher()
    }
}
