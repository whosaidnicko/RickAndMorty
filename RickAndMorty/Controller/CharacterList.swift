//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 09/03/2023.
//

import UIKit
import SDWebImage
import SnapKit

final class CharacterList: UIViewController{
    var path =  IndexPath()
    var idForEpisode = "1"
    var urls: [Any] = []
    private lazy var headerTitle: UILabel = {
        let headerTitle = UILabel()
        headerTitle.text = "Rick and Morty"
        headerTitle.textColor = .black
        headerTitle.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)
        headerTitle.layer.frame = CGRect(x: 25, y: 70, width: 450, height: 37)
        return headerTitle
    }()
    @IBOutlet weak var tableView: UITableView!
    private var episodeModel: [EpisodeModel] = []
    private var heroesModel: [HeroesModel] = []
    private var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerTitle)
        setupTableView()
        getCharacter()
        // TableView settings
        tableView.rowHeight = 120
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        tableView.reloadData()
        //Hiding navBar
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTableView() {
        // TableView constraints
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerTitle.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func getCharacter() {
        // Random page of characters
        let maxNumber = 50
        let randomNumber = String(Int.random(in: 0...maxNumber))
        // Fetching character
        networkManager.getCharacter(url: URLs.urlHeroes + "7", completion: {[weak self] result in
            switch result {
                // Error.
            case .failure(let error):
                print(error.localizedDescription)
                // Succes.
            case .success(let succes):
                // Saving data to heroesModel.
                self?.heroesModel = succes
                // After data is received and saved we call next function.
                self?.getEpisode(isRunSegue: false)
            }
        })
    }
    
    func getEpisode(isRunSegue: Bool) {
        networkManager.getEpisode(url: URLs.urlEpisode + "\(idForEpisode)", completion: {[weak self] result in
            switch result {
                // Error.
            case .failure(let error):
                print(error)
                // Succes.
            case .success(let succes):
                // Receiving data and saving it.
                self?.episodeModel = succes
                
                // Reloading tableView.
                DispatchQueue.main.async {
                    [weak self] in
                    if isRunSegue {
                        self?.performSegue(withIdentifier: "goToDetailedCharacters", sender: self)
                    } else {
                        self?.tableView.reloadData()
                    }
                }
            }
        })
    }
}
//MARK: - UITableView data source
extension CharacterList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returning count of objects received.
        return heroesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        // Set cell UI.
        cell.backgroundColor = .red
        cell.backMainView.layer.masksToBounds = false
        cell.nameHero.text =  heroesModel[indexPath.row].name
        cell.backgroundColor = .black
        cell.labelLocation.text = heroesModel[indexPath.row].nameLocation
        cell.dinamicLabelEpisode.text = heroesModel[0].episode[indexPath.row]
        // Downloading image , cache it , set it.
        if let  imageUrl = URL(string: heroesModel[indexPath.row].img) {
            cell.pictureHero.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
        return cell
    }
}
//MARK: - UITableViewDelegate
extension CharacterList: UITableViewDelegate {
    //Header height.
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  0
    }
    //View for header Section.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let abstractView = UIView()
        return abstractView
    }
    // Actions after user selected row.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Receiving id of episode at location of cell.
        self.idForEpisode =  String(self.heroesModel[0].idForEpisode[indexPath.row])
        // Fetching data of episode with id what we received from cell.
        getEpisode(isRunSegue: true)
        // Going to SecondViewController.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Receiving what cell user tapped.
        let path = tableView.indexPathForSelectedRow
        let index = path?.row
        // Set destination as SecondViewController.
        let detailedCharacterVC = segue.destination as! DetailedCharacterList
        // Set UI for SecondViewController show to user information about character what he choosed.
        guard let index = index else { return }
        let heroesModel = self.heroesModel[index]
        let alsoText = ("Also from \"\(self.episodeModel[0].name)\"")
        let statusImageBorderColor: UIColor
        // logic of setting image if text of status changes
        if heroesModel.status == "Dead" {
            statusImageBorderColor = UIColor.red
        }
        else if heroesModel.status == "Alive" {
            statusImageBorderColor = UIColor.systemGreen
        }
        else {
            statusImageBorderColor = UIColor.purple
        }
        let model: CharactersInfoModel = .init(
            topTitle: heroesModel.name,
            location: heroesModel.nameLocation,
            firstSeenDinamic: self.heroesModel[0].episode[index],
            episodeModel: self.episodeModel[0].name,
            alsoLabel: alsoText,
            statusLabel: heroesModel.status,
            statusImageBorderColor: statusImageBorderColor,
            imageCharacterURL: URL(string: (heroesModel.img)))
        // saving to detailedCharacterVc
        detailedCharacterVC.setupData(model: model)
        //MARK: - Decoding each character from list of episode
        //Going through loop array of json urls
        for characterURL in episodeModel[0].characters{
            guard let url = URL(string: characterURL) else  { continue }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print( "\(error.localizedDescription)")
                }
                if let data = data {
                    do {
                        let jsonCharacterEpisode = try JSONDecoder().decode(DataCharactersEpisode.self, from: data)
                        // Appending each character , to reuse it.
                        detailedCharacterVC.character.append(jsonCharacterEpisode)
                        detailedCharacterVC.urlsForFirstSeen.append(jsonCharacterEpisode.episode[0])
                        // After we appended all characters, we reload tableView of SecondViewController
                        DispatchQueue.main.async {
                            detailedCharacterVC.tableView?.reloadData()
                        }
                    }
                    catch {
                        print("\(error.localizedDescription)")
                    }
                }
            }.resume()
        }
    }
}





















