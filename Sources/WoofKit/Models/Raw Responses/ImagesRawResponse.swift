//
//  File.swift
//  
//
//  Created by Arvind Ravi on 21/02/2021.
//

import Foundation

struct ImagesRawResponse {
    let message: Set<URL>
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case message, status
    }
}

extension ImagesRawResponse: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(Set<URL>.self, forKey: .message)
        status = try container.decode(String.self, forKey: .status)
    }
}
