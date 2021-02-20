//
//  File.swift
//  
//
//  Created by Arvind Ravi on 20/02/2021.
//

import Foundation

struct BreedsRawResponse {
    let message: [Breed]
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case message, status
    }
}

extension BreedsRawResponse: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawListOfBreeds = try container.decode([String: [String]].self, forKey: .message)
        print(rawListOfBreeds)
        message = []
        status = ""
    }
}
