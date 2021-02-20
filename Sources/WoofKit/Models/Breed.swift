//
//  File.swift
//  
//
//  Created by Arvind Ravi on 20/02/2021.
//

import Foundation

public struct Breed: Decodable {
    public let name: String
    public let subBreeds: Set<String>
}
