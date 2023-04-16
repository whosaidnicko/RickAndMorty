//
//  SecondViewController.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 02/04/2023.
//

import UIKit

final class SecondViewController: UIViewController {
    //Adding UI
    public var character = [DataCharactersLocation]()
    public let episodeModel = UILabel()
    public let imageCharacter = UIImageView()
    private let textLastKnown = UILabel()
    public let location = UILabel()
    private let firstSeen = UILabel()
    public  let  firstSeenDinamic = UILabel()
    private let statusText = UILabel()
    private let statusImage = UIImageView()
    public let   statusLabel = UILabel()
    public let alsoLabel = UILabel()
    public let topTitle = UILabel()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //all UI set to the ViewController
        settingAllUI()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        // TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SecondCell", bundle: nil), forCellReuseIdentifier: "SecondCell")
        tableView.rowHeight = 150
        tableView.reloadData()
    }
    //MARK: -  Setting UI
    
    func settingAllUI()  {
        setAlsoLabel()
        setStatusDinamic()
        setStatusImg()
        labelStatus()
        setFirstSeenDinamic()
        setLabelFirstSeen()
        setLabelLocation()
        setTextLastKnown()
        setImageCharacter()
        setTopTitle()
    }
    
    func setAlsoLabel(){
        alsoLabel.layer.frame = CGRect(x: 25, y: 156, width: 400, height: 300)
        alsoLabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 23)
        view.addSubview(alsoLabel)
    }
    
    func setStatusDinamic() {
        statusLabel.layer.frame = CGRect(x: 193, y: 230, width: 100, height: 50)
        statusLabel.textColor = .systemGray
        statusLabel.font = .boldSystemFont(ofSize: 13)
        DispatchQueue.main.async { [weak self] in
            // logic of setting image if text of status changes
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
    }
    
    func setStatusImg() {
        statusImage.layer.frame = CGRect(x: 180, y: 250, width: 10, height: 10)
        statusImage.image = UIImage(systemName: "circle")
        // Making circle
        statusImage.clipsToBounds = true
        statusImage.layer.borderWidth = 5.0
        statusImage.layer.cornerRadius = statusImage.frame.size.width/2
        view.addSubview(statusImage)
    }
    
    func labelStatus() {
        statusText.layer.frame = CGRect(x: 180, y: 220, width: 200, height: 30)
        statusText.text = "Status:"
        statusText.textColor =  #colorLiteral(red: 1, green: 0.6838926673, blue: 0, alpha: 1)
        statusText.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 19)
        view.addSubview(statusText)
    }
    
    func setFirstSeenDinamic() {
        firstSeenDinamic.layer.frame = CGRect(x: 180, y: 190, width: 200, height: 30)
        firstSeenDinamic.textColor = .systemGray
        firstSeenDinamic.font =  .boldSystemFont(ofSize: 13)
        view.addSubview(firstSeenDinamic)
    }
    
    func setLabelFirstSeen() {
        firstSeen.layer.frame = CGRect(x: 180, y: 169, width: 200, height: 30)
        firstSeen.text = "First seen in:"
        firstSeen.textColor =  #colorLiteral(red: 1, green: 0.6838926673, blue: 0, alpha: 1)
        firstSeen.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 19)
        view.addSubview(firstSeen)
    }
    func setLabelLocation() {
        location.layer.frame = CGRect(x: 180, y: 144, width: 300, height: 30)
        location.textColor = .systemGray
        location.font =  .boldSystemFont(ofSize: 12)
        view.addSubview(location)
    }
    
    func setTextLastKnown() {
        textLastKnown.layer.frame = CGRect(x: 180, y: 128, width: 200, height: 20)
        textLastKnown.text = "Last known location:"
        textLastKnown.textColor =  #colorLiteral(red: 1, green: 0.6838926673, blue: 0, alpha: 1)
        textLastKnown.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 19)
        view.addSubview(textLastKnown)
    }
    func setImageCharacter() {
        imageCharacter.layer.frame = CGRect(x: 25, y: 130, width: 150, height: 150)
        imageCharacter.layer.masksToBounds = true
        imageCharacter.layer.cornerRadius = 10
        view.addSubview(imageCharacter)
    }
    
    func setTopTitle() {
        topTitle.textColor = .black
        topTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        topTitle.sizeToFit()
        topTitle.numberOfLines = 2
        topTitle.layer.frame = CGRect(x: 25, y: 70, width: 400, height: 50)
        topTitle.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)
        view.addSubview(topTitle)
    }
    
    
}





//MARK: - UITableViewDataSource
extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //returning number sections
        return character.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondCell
        //Setting UI for cell
        cell.nameHero.text = character[indexPath.row].name
        cell.labelLocation.text = character[indexPath.row].location.name
        cell.dinamicLabelEpisode.text =  episodeModel.text
        cell.backgroundColor = .white
        // Cache image + setting
        if let  imageUrl = URL(string: character[indexPath.row].image) {
            cell.pictureHero.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
        
        return cell
    }
}
//MARK: - UITableViewDelegate
extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Action after user tapped cell
        DispatchQueue.main.async {
            // Setting UI
            self.topTitle.text = self.character[indexPath.row].name
            self.location.text = self.character[indexPath.row].location.name
            self.statusLabel.text = self.character[indexPath.row].status
            //Cache image + set it
            if let  imageUrl = URL(string: self.character[indexPath.row].image) {
                self.imageCharacter.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
            }
            // Logic of statusImage
            if self.statusLabel.text == "Dead" {
                self.statusImage.layer.borderColor = UIColor.red.cgColor
                
            }
            else if self.statusLabel.text == "Alive" {
                self.statusImage.layer.borderColor = UIColor.systemGreen.cgColor
                
            }
            else {
                self.statusImage.layer.borderColor = UIColor.purple.cgColor
                
            }
        }
    }
}
