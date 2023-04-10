//
//  HeroesManager.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 09/03/2023.
//

import UIKit

struct NetworkManager {
    
    func getPost(url: String, completion: @escaping(Swift.Result<[HeroesModel], Error> ) -> Void) {
        
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    
                    let json = try JSONDecoder().decode(HeroesData.self, from: data)
                    
                    let results: [HeroesModel] = json.results.map {.init(name: $0.name, img: $0.image, nameLocation: $0.location.name, status: $0.status, id: $0.id)}
       
                    completion(.success(results))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    func getEpisode(url: String, completion: @escaping(Swift.Result<[EpisodeModel], Error> ) -> Void) {
        
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    
                    let json = try JSONDecoder().decode(EpisodeData.self, from: data)
                    
                    let results: [EpisodeModel] = json.results.map {.init(name: $0.name, characters: $0.characters)}
                    var characters = [DataCharactersLocation]()
                  
                    
                    
                    
                    
                    completion(.success(results))
                    
                    
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
