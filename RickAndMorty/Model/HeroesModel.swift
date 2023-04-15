//
//  HeroesModel.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 15/03/2023.
//

import Foundation


struct HeroesModel:Decodable {
    public let name: String
    public let img: String
    public let nameLocation: String
    public let status: String
    public let id: Int
    public let episode: [String]

}
