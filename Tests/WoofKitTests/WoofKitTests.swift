import XCTest
@testable import WoofKit

final class WoofKitTests: XCTestCase {
    
    func test_getsListOfBreeds() {
        let expectation = XCTestExpectation(description: "wait")
        WoofKit.shared.fetchBreeds { result in
            switch result {
            case .success(let breeds):
                print(breeds)
                expectation.fulfill()
            case .failure(let error):
                print(error)
                expectation.fulfill()
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
