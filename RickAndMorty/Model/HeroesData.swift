//
//  HeroesData.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 09/03/2023.
//

import Foundation

struct HeroesData: Decodable {
    public let results : [Result]
  
    
}

struct Result: Decodable {
     
public let  name : String
public  let image: String
    public let location : Locations
    
    
}
struct Locations: Decodable {
    public let name: String
    
}




     
