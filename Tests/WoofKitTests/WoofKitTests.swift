import XCTest
@testable import WoofKit

final class WoofKitTests: XCTestCase {
    
    func test_getsListOfBreeds() {
        let expectation = XCTestExpectation(description: "wait")
        WoofKit.shared.fetchBreeds { result in
            switch result {
            case .success(let breeds):
                print(breeds)
                XCTAssert(breeds.count > 0)
            case .failure(let error):
                print(error)
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.3)
    }
    
    func test_getsListOfImagesForBreed() {
        let expectation = XCTestExpectation(description: "wait")
        WoofKit.shared.fetchImages(for: .mockBreed) { (result) in
            switch result {
            case .success(let images):
                print(images)
            case .failure(let error):
                print(error)
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}


extension Breed {
    static var mockBreed: Breed = Breed(name: "redbone", subBreeds: .init())
}
