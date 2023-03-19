//
//  HeroesData.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 09/03/2023.
//

import Foundation

struct HeroesData: Decodable {
    let results : [Result]
  
    
}

struct Result: Decodable {

   let  name : String
    let image: String
    
    
}




     
