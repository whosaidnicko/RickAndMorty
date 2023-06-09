//
//  SecondViewController.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 02/04/2023.
//

import UIKit
import SnapKit
import SDWebImage

final class DetailedCharacterList: UIViewController {
    private var nameFirstSeen = [String]()
    public var characterModel: CharactersInfoModel = .template
    public var urlsForFirstSeen = [String]()
    public var character = [DataCharactersEpisode]()
    //Adding UI
    public let backButton = UIButton(type: .system)
    public let episodeModel = UILabel()
    public var imageCharacter = UIImageView()
    private let textLastKnown = UILabel()
    public let location = UILabel()
    private let firstSeen = UILabel()
    public  let  firstSeenDinamic = UILabel()
    private let statusText = UILabel()
    var statusImage = UIView()
    public let   statusLabel = UILabel()
    public let alsoLabel = UILabel()
    public let topTitle = UILabel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //all UI set to the ViewController
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        tableView.rowHeight = 120
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }
    // Actions after backButton pressed.
    @objc func backButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func setupData(model: CharactersInfoModel) {
        // Saving character object
        self.characterModel = model
        settingAllUI()
    }
    //MARK: -  Setting UI
    func settingAllUI() {
        createButton()
        setTopTitle()
        setImageCharacter()
        setTextLastKnown()
        setLabelLocation()
        setLabelFirstSeen()
        setFirstSeenDinamic()
        labelStatus()
        setStatusImg()
        setStatusDinamic()
        setAlsoLabel()
        setupTableView()
    }
    
    private func setupTableView() {
        // TableView constraints
        tableView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(alsoLabel.snp.bottom).offset(10)
        }
    }
    
    func createButton() {
        let textBack = "Back"
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        // Add the button to the view
        view.addSubview(backButton)
        let width = UIScreen.main.bounds.width - 50
        let height = ceil((textBack.height(
            withConstrainedWidth: width,
            font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 19) ?? .systemFont(ofSize: 19))))
        // Constraints for button
        var filledConfiguration = UIButton.Configuration.filled()
        filledConfiguration.title = textBack
        filledConfiguration.image = UIImage(systemName:"arrow.left")
        filledConfiguration.imagePadding = 10
        filledConfiguration.baseBackgroundColor = .white
        filledConfiguration.baseForegroundColor = .black
        filledConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        backButton.configuration = filledConfiguration
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(height)
            make.leading.equalToSuperview().offset(25)
        }
    }
    
    func setTopTitle() {
        topTitle.textColor = .black
        topTitle.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)
        topTitle.numberOfLines = 0
        topTitle.lineBreakMode = .byWordWrapping
        topTitle.text = characterModel.topTitle
        let width = UIScreen.main.bounds.width - 50
        let height = ceil(characterModel.topTitle.height(
            withConstrainedWidth: width,
            font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 35) ?? .systemFont(ofSize: 35)))
        view.addSubview(topTitle)
        topTitle.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(height)
        }
    }
    
    func setImageCharacter() {
        view.addSubview(imageCharacter)
        imageCharacter.snp.makeConstraints { make in
            make.top.equalTo(topTitle.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(25)
            make.width.equalTo(140)
            make.height.equalTo(140)
        }
        // Making rounded
        imageCharacter.layer.masksToBounds = true
        imageCharacter.layer.cornerRadius = 10
        // Downloading image, cache it and set it.
        if let imageUrl = characterModel.imageCharacterURL {
            imageCharacter.sd_setImage(
                with: imageUrl,
                placeholderImage:UIImage(named: "placeholder")
            )
        }
    }
    
    func setTextLastKnown() {
        view.addSubview(textLastKnown)
        textLastKnown.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 19)
        textLastKnown.text = "Last known location:"
        textLastKnown.textColor =  #colorLiteral(red: 1, green: 0.6838926673, blue: 0, alpha: 1)
        let width = UIScreen.main.bounds.width - 50
        let height = ceil((textLastKnown.text!.height(
            withConstrainedWidth: width,
            font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 19) ?? .systemFont(ofSize: 19))))
        textLastKnown.snp.makeConstraints { make in
            make.top.equalTo(imageCharacter.snp.top).offset(-3)
            make.leading.equalTo(imageCharacter.snp.trailing).offset(7)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(height)
        }
    }
    
    func setLabelLocation() {
        view.addSubview(location)
        location.textColor = .systemGray
        location.font =  .boldSystemFont(ofSize: 12)
        location.numberOfLines = 0
        location.lineBreakMode = .byWordWrapping
        location.preferredMaxLayoutWidth = 200
        location.text = characterModel.location
        let width = UIScreen.main.bounds.width - 197
        let height = ceil((characterModel.location.height(
            withConstrainedWidth: width,
            font: UIFont(name: "boldSystemFont", size: 12) ?? .systemFont(ofSize: 12))))
        location.snp.makeConstraints { make in
            make.top.equalTo(textLastKnown.snp.bottom).offset(1)
            make.leading.equalTo(textLastKnown)
            make.trailing.equalTo(textLastKnown)
            make.height.equalTo(height)
        }
    }
    
    func setLabelFirstSeen() {
        view.addSubview(firstSeen)
        firstSeen.layer.frame = CGRect(x: 180, y: 169, width: 200, height: 30)
        firstSeen.text = "First seen in:"
        firstSeen.textColor =  #colorLiteral(red: 1, green: 0.6838926673, blue: 0, alpha: 1)
        firstSeen.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 19)
        let width = UIScreen.main.bounds.width - 50
        let height = ceil((firstSeen.text!.height(
            withConstrainedWidth: width,
            font: UIFont(name: "boldSystemFont", size: 12) ?? .systemFont(ofSize: 12))))
        firstSeen.snp.makeConstraints { make in
            make.top.equalTo(location.snp.bottom).offset(10)
            make.leading.equalTo(location)
            make.trailing.equalTo(location)
            make.height.equalTo(height)
        }
    }
    
    func setFirstSeenDinamic() {
        view.addSubview(firstSeenDinamic)
        firstSeenDinamic.textColor = .systemGray
        firstSeenDinamic.font =  .boldSystemFont(ofSize: 13)
        firstSeenDinamic.numberOfLines = 0
        firstSeenDinamic.lineBreakMode = .byWordWrapping
        firstSeenDinamic.text = characterModel.firstSeenDinamic
        let width = UIScreen.main.bounds.width - 197
        let height = ceil(characterModel.firstSeenDinamic.height(
            withConstrainedWidth: width,
            font: .boldSystemFont(ofSize: 13)))
        firstSeenDinamic.snp.makeConstraints { make in
            make.top.equalTo(firstSeen.snp.bottom).offset(3)
            make.leading.equalTo(firstSeen)
            make.trailing.equalTo(firstSeen)
            make.height.equalTo(height)
        }
    }
    
    func labelStatus() {
        view.addSubview(statusText)
        //statusText.layer.frame = CGRect(x: 180, y: 220, width: 200, height: 30)
        statusText.text = "Status:"
        statusText.textColor =  #colorLiteral(red: 1, green: 0.6838926673, blue: 0, alpha: 1)
        statusText.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 19)
        let width = UIScreen.main.bounds.width - 50
        let height = ceil((statusText.text!.height(
            withConstrainedWidth: width,
            font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 19) ?? .systemFont(ofSize: 19))))
        statusText.snp.makeConstraints { make in
            make.top.equalTo(firstSeenDinamic.snp.bottom).offset(6)
            make.leading.equalTo(firstSeenDinamic)
            make.trailing.equalTo(firstSeenDinamic)
            make.height.equalTo(height)
        }
    }
    
    func setStatusImg() {
        view.addSubview(statusImage)
        // Making circle
        statusImage.backgroundColor = characterModel.statusImageBorderColor
        statusImage.snp.makeConstraints { make in
            make.top.equalTo(statusText.snp.bottom).offset(4)
            make.leading.equalTo(statusText.snp.leading)
            make.width.equalTo(8)
            make.height.equalTo(8)
        }
        // Making circle
        statusImage.layer.cornerRadius = 4
        statusImage.clipsToBounds = true
    }
    
    func setStatusDinamic() {
        view.addSubview(statusLabel)
        statusLabel.textColor = .systemGray
        statusLabel.font = .boldSystemFont(ofSize: 13)
        statusLabel.text = characterModel.statusLabel
        let width = UIScreen.main.bounds.width - 50
        let height = ceil((characterModel.firstSeenDinamic.height(
            withConstrainedWidth: width,
            font: UIFont(name: "boldSystemFont", size: 13) ?? .systemFont(ofSize: 13))))
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(statusImage.snp.top).offset(-3)
            make.leading.equalTo(statusImage).offset(13)
            make.trailing.equalTo(firstSeenDinamic)
            make.height.equalTo(height)
        }
    }
    
    func setAlsoLabel(){
        view.addSubview(alsoLabel)
        alsoLabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 22)
        alsoLabel.numberOfLines = 0
        alsoLabel.lineBreakMode = .byWordWrapping
        alsoLabel.preferredMaxLayoutWidth = 160
        alsoLabel.textColor = .black
        alsoLabel.text = characterModel.alsoLabel
        let width = UIScreen.main.bounds.width - 50
        let height = ceil((characterModel.alsoLabel.height(
            withConstrainedWidth: width,
            font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 22) ?? .systemFont(ofSize: 22))))
        alsoLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(height)
        }
    }
}
//MARK: - UITableViewDataSource
extension DetailedCharacterList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //returning number rows
        return character.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        //returning number sections
        1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Setting height for section
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else { return .init(frame: .zero) }
        //Setting UI for cell
        cell.nameHero.text = character[indexPath.row].name
        cell.labelLocation.text = character[indexPath.row].location.name
        cell.dinamicLabelEpisode.text = characterModel.episodeModel
        cell.backgroundColor = .white
        
        // Cache image + setting
        if let  imageUrl = URL(string: character[indexPath.row].image) {
            cell.pictureHero.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
        return cell
    }
}
//MARK: - UITableViewDelegate
extension DetailedCharacterList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Action after user tapped cell
        // Creating dispatch to acces  names where they been seen first time.
        let dispatchGroup = DispatchGroup()
        // going through loop to show first episode name
        for firstSeenUrl in urlsForFirstSeen {
            guard let url = URL(string: firstSeenUrl) else  { continue }
            // enter dispatch
            dispatchGroup.enter()
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print( "\(error.localizedDescription)")
                }
                if let data = data {
                    do {
                        let jsonNameEpisode = try JSONDecoder().decode(EpisodeModel.self, from: data)
                        let nameFirstSeen = jsonNameEpisode.name
                        // appending name of episode in variable
                        self.nameFirstSeen.append(nameFirstSeen)
                    }
                    catch {
                        print("\(error.localizedDescription)")
                    }
                }
                dispatchGroup.leave()
            }.resume()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            
            let characterModel = self.character[indexPath.row]
            let statusImageBorderColor: UIColor
            // Logic of statusImage
            if characterModel.status == "Dead" { // Dead
                statusImageBorderColor = UIColor.red
            }
            else if characterModel.status == "Alive" { // Alive
                statusImageBorderColor = UIColor.systemGreen
            }
            else { // unknown
                statusImageBorderColor = UIColor.purple
            }
            //  init model  for new ViewController
            let model: CharactersInfoModel = .init(
                topTitle: characterModel.name,
                location: characterModel.location.name,
                firstSeenDinamic: self.nameFirstSeen[indexPath.row],
                episodeModel: self.characterModel.episodeModel,
                alsoLabel: self.characterModel.alsoLabel,
                statusLabel: characterModel.status,
                statusImageBorderColor: statusImageBorderColor,
                imageCharacterURL: URL(string: characterModel.image))
            // Get needed story board.
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Created new ViewController
            let myNewViewController = storyboard.instantiateViewController(identifier: "SecondViewController") as? DetailedCharacterList
            // We saved data in new ViewController
            myNewViewController?.nameFirstSeen = self.nameFirstSeen
            myNewViewController?.setupData(model: model)
            myNewViewController?.character = self.character
            // Push new ViewController
            self.navigationController?.pushViewController(myNewViewController ?? .init(nibName: nil, bundle: nil), animated: true)
        }
    }
}

