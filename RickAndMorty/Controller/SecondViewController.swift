//
//  SecondViewController.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 02/04/2023.
//

import UIKit

final class SecondViewController: UIViewController {
    var episodeModel = UILabel()
      var character = [DataCharactersLocation]()
    var episode = [EpisodeModel]()
    var totalNumbersCharacters = 0
    var nameHeroForCell: String = ""
    var listOfCharacters = [HeroesModel]()
    var numberIndex = 0
    var topTitle = UILabel()
    var imageCharacter = UIImageView()
    let textLastKnown = UILabel()
    var location = UILabel()
    let firstSeen = UILabel()
    var episodeText = UILabel()
    let statusText = UILabel()
    let statusImage = UIImageView()
    var statusLabel = UILabel()
    let alsoLabel = UILabel()

        
    @IBOutlet weak var tableView: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(character)
      
      
      
        
     

        
        alsoLabel.layer.frame = CGRect(x: 25, y: 156, width: 400, height: 300)
        alsoLabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 23)
        view.addSubview(alsoLabel)
        
        statusLabel.layer.frame = CGRect(x: 193, y: 230, width: 100, height: 50)
        statusLabel.textColor = .systemGray
        statusLabel.font = .boldSystemFont(ofSize: 13)
        DispatchQueue.main.async { [weak self] in
            
            
            if self?.statusLabel.text == "Dead" {
                self!.statusImage.layer.borderColor = UIColor.red.cgColor
                
            }
            else if self?.statusLabel.text == "Alive" {
                self!.statusImage.layer.borderColor = UIColor.systemGreen.cgColor
                
            }
            else {
                self!.statusImage.layer.borderColor = UIColor.purple.cgColor
                
            }
        }
        
        view.addSubview(statusLabel)
        
        statusImage.layer.frame = CGRect(x: 180, y: 250, width: 10, height: 10)
       
        statusImage.layer.cornerRadius = statusImage.frame.size.width/2
        statusImage.image = UIImage(systemName: "circle")
        statusImage.clipsToBounds = true

     
        statusImage.layer.borderWidth = 5.0
      
        view.addSubview(statusImage)
        
        statusText.layer.frame = CGRect(x: 180, y: 220, width: 200, height: 30)
        statusText.text = "Status:"
        statusText.textColor =  #colorLiteral(red: 1, green: 0.6838926673, blue: 0, alpha: 1)
        statusText.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 19)
        view.addSubview(statusText)
        
        episodeText.layer.frame = CGRect(x: 180, y: 190, width: 200, height: 30)
        episodeText.textColor = .systemGray
        episodeText.font =  .boldSystemFont(ofSize: 13)
        view.addSubview(episodeText)
        
        firstSeen.layer.frame = CGRect(x: 180, y: 169, width: 200, height: 30)
        firstSeen.text = "First seen in:"
        firstSeen.textColor =  #colorLiteral(red: 1, green: 0.6838926673, blue: 0, alpha: 1)
        firstSeen.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 19)
        view.addSubview(firstSeen)
        
        location.layer.frame = CGRect(x: 180, y: 144, width: 300, height: 30)
        location.textColor = .systemGray
        location.font =  .boldSystemFont(ofSize: 13)
        
        view.addSubview(location)
        
        textLastKnown.layer.frame = CGRect(x: 180, y: 128, width: 200, height: 20)
        textLastKnown.text = "Last known location:"
        textLastKnown.textColor =  #colorLiteral(red: 1, green: 0.6838926673, blue: 0, alpha: 1)
        textLastKnown.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 19)
        view.addSubview(textLastKnown)
        
     
        imageCharacter.layer.frame = CGRect(x: 25, y: 130, width: 150, height: 150)
        
        imageCharacter.layer.masksToBounds = true
        imageCharacter.layer.cornerRadius = 10
        view.addSubview(imageCharacter)

        topTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        topTitle.sizeToFit()
        topTitle.numberOfLines = 2
        topTitle.layer.frame = CGRect(x: 25, y: 70, width: 400, height: 50)
        topTitle.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)
        view.addSubview(topTitle)

        tableView.dataSource = self
        tableView.register(UINib(nibName: "SecondCell", bundle: nil), forCellReuseIdentifier: "SecondCell")
     
        tableView.rowHeight = 150
        tableView.reloadData()
        
    }
    
    
}






extension SecondViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
      totalNumbersCharacters
      
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondCell
        DispatchQueue.main.async { [self] in
            cell.nameHero.text = character[indexPath.row].name
            cell.pictureHero.downloaded(from: character[indexPath.row].image)
            cell.labelLocation.text = character[indexPath.row].location.name
            cell.dinamicLabelEpisode.text =  episodeModel.text
                
        }


  
        return cell
    }
}
