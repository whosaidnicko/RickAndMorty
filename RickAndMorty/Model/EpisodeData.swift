//
//  LocationData.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 01/04/2023.
//

import Foundation

struct EpisodeData: Decodable {
    public let name: String
    public let characters: [String]
    public let id: Int
}

