//
//  HeroesManager.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 09/03/2023.
//

import UIKit

struct NetworkManager {
  
    mutating func getPost(url: String, completion: @escaping(Swift.Result<[HeroesModel], Error> ) -> Void) {
        var episode1 = [EpisodeModel]()
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    
                    let json = try JSONDecoder().decode(HeroesData.self, from: data)
                    let urlss = json.results.map({$0.episode.first})
                    var urls = [String]()
                    for urlse in urlss {
                        urls.append(urlse ?? "Nothing")
                    }
                    let group = DispatchGroup()
                    for urlEpFirst in urls {
                        guard let url = URL(string: urlEpFirst ) else  { continue }
                        group.enter()
                        URLSession.shared.dataTask(with: url) {  (data, response, error) in
                            if let error = error {
                                print( "\(error.localizedDescription)")
                            }
                            if let data = data {
                                do {
                                    let json1 = try JSONDecoder().decode(EpisodeModel.self, from: data)
                                 
                                    episode1.append(json1)
                                  
                                }
                                catch {
                                    print("\(error.localizedDescription)")
                                }
                            }
                            group.leave() }
                        .resume()
                        
                    }
                    group.notify(queue: .main) {
                   
                        let episodos = episode1.map({ $0.name })
                   
                     
                        let results: [HeroesModel] = json.results.map {.init(name: $0.name, img: $0.image, nameLocation: $0.location.name, status: $0.status, id: $0.id, episode: episodos)}
                        completion(.success(results))
                       
                                       }
                   
                     
                 
                  
                
                 
                    
       
                    
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
    func getNameEpisode() {
        
    }
    
}
