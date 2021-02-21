//
//  File.swift
//  
//
//  Created by Arvind Ravi on 21/02/2021.
//

import XCTest
@testable import WoofKit

final class ImageLoaderTests: XCTestCase {
    
    let subject = ImageLoader()
    
    func test_loadsValidImage() {
        let mockImageURL = URL(string: "https://images.dog.ceo/breeds/redbone/n02090379_3410.jpg")!
        let expectation = XCTestExpectation(description: "wait")
        subject.loadImage(for: mockImageURL as NSURL) { result in
            switch result {
            case .success: expectation.fulfill()
            case .failure: XCTFail()
            }
        }
        wait(for: [expectation], timeout: 0.3)
    }
}
