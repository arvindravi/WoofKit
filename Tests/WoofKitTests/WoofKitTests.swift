import XCTest
@testable import WoofKit

final class WoofKitTests: XCTestCase {
    
    func test_getsListOfBreeds() {
        WoofKit.shared.fetchBreeds { result in
            switch result {
            case .success(let breeds): print(breeds)
            case .failure(let error): print(error)
            }
        }
    }
}