//
//  File.swift
//  
//
//  Created by Arvind Ravi on 20/02/2021.
//

import Foundation

public struct Breed: Decodable {
    let name: String
    let subBreeds: Set<String>
}
