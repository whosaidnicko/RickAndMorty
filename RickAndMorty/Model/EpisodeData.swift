//
//  LocationData.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 01/04/2023.
//

import Foundation


struct EpisodeData: Decodable {
    public let results: [Results]
    
}

struct Results: Decodable {
    public let name: String
}
