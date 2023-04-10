//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 09/03/2023.
//

import UIKit



final class ViewController: UIViewController{
    var path =  IndexPath()
    var characters = [DataCharactersLocation]()
    
    
    
    private  var headerTitle: UILabel{
        let headerTitle = UILabel()
        headerTitle.text = "Rick and Morty"
        headerTitle.textColor = .black
        headerTitle.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)
        headerTitle.layer.frame = CGRect(x: 25, y: 95, width: 450, height: 37)
        view.addSubview(headerTitle)
        return headerTitle
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var     result: [Result] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var episodeModel: [EpisodeModel] = []
    private var heroesModel: [HeroesModel] = []
    private let urls = URLs()
    private var networkManager = NetworkManager()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIFont.familyNames.forEach({ familyName in
        //  let fontNames = UIFont.fontNames(forFamilyName: familyName)
        //print(familyName, fontNames)
        //  })
        
        headerTitle
        tableView.rowHeight = 120
        tableView.estimatedRowHeight = 120
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CellHero")
        tableView.reloadData()
        getPost()
        
        
        
       
        
    
        
       
        
        
        
    }
    func getPost() {
        
        networkManager.getPost(url: URLs.urlHeroes, completion: {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let succes):
                print("Data is succsfull fetched !")
                self?.heroesModel = succes
                self?.getEpisode()
              
                
                
                
                
                
            }
        })
        
    }
    func getEpisode() {
        networkManager.getEpisode(url: URLs.urlEpisode, completion: {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let succes):
                print("Data is succsfull fetched !")
                self?.episodeModel = succes
                DispatchQueue.main.async {
                    [weak self] in
                    self?.tableView.reloadData()
                }
             
                
                
            }
        })
        
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
    func makeRounded() {
        let radius = self.bounds.height / 2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        
        self.contentMode = .scaleAspectFill
    }
}



//MARK: - UITableView data source

extension ViewController: UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return heroesModel.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellHero", for: indexPath) as! TableViewCell
        
        cell.backgroundColor = .red
        cell.backMainView.layer.masksToBounds = false
        cell.nameHero.text =  heroesModel[indexPath.row].name
        
        cell.backgroundColor = .black
        cell.pictureHero.downloaded(from: heroesModel[indexPath.row].img  , contentMode: .scaleAspectFill)
        cell.labelLocation.text = heroesModel[indexPath.row].nameLocation
        cell.dinamicLabelEpisode.text = episodeModel[indexPath.row].name
        
        return cell
        
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  55
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let abstractView = UIView()
        
        
        return abstractView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            self.performSegue(withIdentifier: "goToDetailedCharacters", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let path = tableView.indexPathForSelectedRow
         let index = path?.row
        
        let secondVc = segue.destination as! SecondViewController
        DispatchQueue.main.async {
            
            if index != nil {
                secondVc.topTitle.text =  self.heroesModel[index!].name
                secondVc.imageCharacter.downloaded(from: self.heroesModel[index!].img, contentMode: .scaleToFill)
                secondVc.location.text = self.heroesModel[index!].nameLocation
                secondVc.episodeText.text = self.episodeModel[index!].name
                secondVc.statusLabel.text = self.heroesModel[index!].status
                secondVc.episodeModel.text = self.episodeModel[index!].name
                secondVc.character.remove(at: index!)
            }
            
      
      
            
        }
      
       
        secondVc.totalNumbersCharacters = self.episodeModel[index!].characters.count
        secondVc.numberIndex = index!
        
        
        
        secondVc.alsoLabel.text = ("Also from \"\(episodeModel[index!].name)\"")
        
        
        let sourceText = episodeModel[index!].characters
        var characterID = extractNumbers(from: sourceText)
        
        
        
        
        
        
        
        for characterURL in episodeModel[index!].characters{
            
            
            guard let url = URL(string: characterURL) else  {print("it doesn't work closure")
                continue
            }
            URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
                if let error = error {
                    print( "\(error.localizedDescription)")
                }
                if let data = data {
                    do {
                        
                        let jsonCharactersLocation = try JSONDecoder().decode(DataCharactersLocation.self, from: data)
                        
                        
                        characters.append(jsonCharactersLocation)
                        secondVc.character.append(jsonCharactersLocation)
                        DispatchQueue.main.async { 
                            secondVc.tableView.reloadData()
                        }
                        
                        
                      
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    catch {
                        print("\(error.localizedDescription)")
                    }
                }
                
                
                
            }.resume()
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    func extractNumbers(from array: [String]) -> [Int] {
        var result = [Int]()
        let regex = try! NSRegularExpression(pattern: "\\d+")
        
        for string in array {
            let range = NSRange(location: 0, length: string.utf16.count)
            let matches = regex.matches(in: string, options: [], range: range)
            
            for match in matches {
                if let number = Int((string as NSString).substring(with: match.range)) {
                    result.append(number)
                }
            }
        }
        
        return result
    }
    
}
extension String {
    func parseToInt() -> Int? {
        return Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}

















