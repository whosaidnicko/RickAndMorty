//
//  URLs.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 09/03/2023.
//

import Foundation

struct URLs {
     static var urlHeroes = "https://rickandmortyapi.com/api/character?page=\(randomNumber)"
    static let urlEpisode = "https://rickandmortyapi.com/api/episode"
}
let maxNumber = 40
let randomNumber = Int.random(in: 0...maxNumber)
