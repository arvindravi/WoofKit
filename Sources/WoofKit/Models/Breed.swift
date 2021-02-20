//
//  File.swift
//  
//
//  Created by Arvind Ravi on 20/02/2021.
//

import Foundation

public struct Breed {
    public let name: String
    public let subBreeds: Set<String>
}

extension Breed: Decodable, Hashable {}
