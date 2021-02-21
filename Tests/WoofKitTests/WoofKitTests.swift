import XCTest
@testable import WoofKit

final class WoofKitTests: XCTestCase {
    
    func test_getsListOfBreeds() {
        let expectation = XCTestExpectation(description: "wait")
        WoofKit.shared.fetchBreeds { result in
            switch result {
            case .success(let breeds):
                XCTAssert(breeds.count > 0)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    func test_getsListOfImagesForBreed() {
        let expectation = XCTestExpectation(description: "wait")
        WoofKit.shared.fetchImages(for: Breed.mockBreed.name) { (result) in
            switch result {
            case .success(let images):
                XCTAssert(images.count > 0)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
}


extension Breed {
    static var mockBreed: Breed = Breed(name: "redbone", subBreeds: .init())
}
