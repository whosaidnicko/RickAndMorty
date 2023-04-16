//
//  HeroesManager.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 09/03/2023.
//

import UIKit

struct NetworkManager {
    
    //MARK: -  Logic of fetching
    mutating func getCharacter(url: String, completion: @escaping(Swift.Result<[HeroesModel], Error> ) -> Void) {
        // Creating variable to append objects in.
        var episodeModel = [EpisodeModel]()
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            //Error.
            if let error = error {
                completion(.failure(error))
            }
            //Succes.
            if let data = data {
                do {
                    // Decoding data
                    let json = try JSONDecoder().decode(HeroesData.self, from: data)
                    // Going through each character and getting first episode he was seen.
                    let urlss = json.results.map({$0.episode.first})
                    
                    var urls = [String]()
                    // Going through loop.
                    for urlse in urlss {
                        urls.append(urlse ?? "Nothing")
                    }
                    // Creating DispatchGroup to save in episode name name/id.
                    let group = DispatchGroup()
                    for urlEpFirst in urls {
                        guard let url = URL(string: urlEpFirst ) else  { continue }
                        group.enter()
                        URLSession.shared.dataTask(with: url) {  (data, response, error) in
                            if let error = error {
                                print( "\(error.localizedDescription)")
                            }
                            // Succes.
                            if let data = data {
                                do {
                                    //Decoding json.
                                    let json = try JSONDecoder().decode(EpisodeModel.self, from: data)
                                    // Appending to episodeModel characters which were in episode.
                                    DispatchQueue.main.async {
                                        episodeModel.append(json)
                                    }
                                }
                                // Error.
                                catch {
                                    print("\(error.localizedDescription)")
                                }
                            }
                            group.leave() }
                        .resume()
                        
                    }
                    group.notify(queue: .main) {
                        // Saving name/id.
                        let episodeName = episodeModel.map({ $0.name })
                        let idForEpisode = episodeModel.map({$0.id })
                        print(idForEpisode)
                        
                        // Init HeroesModel.
                        let results: [HeroesModel] = json.results.map {.init(name: $0.name, img: $0.image, nameLocation: $0.location.name, status: $0.status, id: $0.id, episode: episodeName, idForEpisode: idForEpisode)}
                        // Saving it
                        completion(.success(results))
                        
                    }
                }
                // Error.
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
            // Error.
            if let error = error {
                completion(.failure(error))
            }
            // Succes.
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(EpisodeData.self, from: data)
                    //init.
                    let results = [EpisodeModel(name: json.name, characters: json.characters, id: json.id)]
                    // Saving results.
                    completion(.success(results))
                }
                // Error/
                catch {
                    
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
