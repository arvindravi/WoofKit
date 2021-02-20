import XCTest
@testable import WoofKit

final class WoofKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WoofKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
