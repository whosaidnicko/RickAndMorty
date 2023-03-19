//
//  HeroesManager.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 09/03/2023.
//

import UIKit


protocol HeroesManagerDelegate {
    func fetchHeroData(_: HeroesManager, hero: HeroesModel) 
    func didFailWithError(error: Error)
    
}

struct HeroesManager {
    
    var delegate: HeroesManagerDelegate?
    func getPost(url: String, completion: @escaping(Swift.Result<HeroesData, Error> ) -> Void) {
         
         guard let url = URL(string: url) else { return }
         let session = URLSession.shared
         session.dataTask(with: url) { data, response, error in
             if let error = error {
                 self.delegate?.didFailWithError(error: error)
             }
             if let data = data {
                 do {
                     var names = ["e"]
                     let json = try JSONDecoder().decode(HeroesData.self, from: data)
                     DispatchQueue.main.async {
                         let heroesModel = HeroesModel(name: json.results[0].name,
                                                       img: json.results[0].image)
                         print("from model \(json.results[0].name)")
                         
                         self.delegate?.fetchHeroData(self, hero: heroesModel)
                     }
             
                 }
                 catch {
                     self.delegate?.didFailWithError(error: error)
                 }
             }
         }.resume()
     }
 }
