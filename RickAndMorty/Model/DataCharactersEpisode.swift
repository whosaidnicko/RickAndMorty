//
//  DataCharactersLocation.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 09/04/2023.
//

import Foundation

struct DataCharactersEpisode:Decodable {
    public let name: String
    public let image: String
    public let location: Locations
    public let status: String
}

