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
                expectation.fulfill()
            case .failure(let error):
                print(error)
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.3)
    }
    
    func test_getsListOfImagesForBreed() {
        let expectation = XCTestExpectation(description: "wait")
        WoofKit.shared.fetchImages(for: Breed.mockBreed.name) { (result) in
            switch result {
            case .success(let images):
                print(images)
                expectation.fulfill()
            case .failure(let error):
                print(error)
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
}


extension Breed {
    static var mockBreed: Breed = Breed(name: "redbone", subBreeds: .init())
}
