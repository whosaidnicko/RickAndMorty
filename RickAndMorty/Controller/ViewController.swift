//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 09/03/2023.
//

import UIKit



class ViewController: UIViewController{
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var     result: [Result?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var heroesModel: HeroesModel?
    let urls = URLs()
    var heroesManager = HeroesManager()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroesManager.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CellHero")
        heroesManager.getPost(url: URLs.url, completion: {result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let succes):
                print(succes)
               
                
            }
        })
        
        
        tableView.reloadData()
    }
    
  
    
  
}

//MARK: -  download Image
extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

//MARK: - protocol HeroesManagerDelegate

extension ViewController: HeroesManagerDelegate {
    func fetchHeroData(_: HeroesManager, hero: HeroesModel) {
        print("this comes from protocol = \(hero.name)")
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    

}

//MARK: - UITableView data source

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellHero", for: indexPath) as! TableViewCell
        //MARK: - Mne nujno shtobi tyt proisholido change name , no tut nichego ne proishodit potomushto heroesModel?.name = nil , pochemu iz jsona nichego ne peraiotsa , i kak zdelati shtobi peredavalosi :D 
        cell.nameHero.text = heroesModel?.name
        
        
   
        return cell
  
    }
}




