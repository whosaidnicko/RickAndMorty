//
//  DataCharactersLocation.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 09/04/2023.
//

import Foundation

struct DataCharactersLocation:Decodable {
    let name: String
    let image: String
    let location: Locations
}

