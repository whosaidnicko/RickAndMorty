//
//  TableViewCell.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 15/03/2023.
//

import UIKit
import SnapKit

//MARK: -  SETTING UI

class CharacterCell: UITableViewCell{
    lazy var nameHero = UILabel()
    lazy var  pictureHero = UIImageView()
    lazy var entireView = UIView()
    lazy  var yo  = UILabel()
    lazy var shadow = UIView()
    lazy var backMainView = UIView()
    lazy var labelLocation = UILabel()
    lazy var staticLabelEpisode = UILabel()
    lazy var dinamicLabelEpisode = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureHero.image = UIImage(named: "placeholder-image")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setAllUI()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setAllUI() {
        setShadow()
        backMainViewSet()
        setImage()
        setNameHero()
        setLabelLocation()
        setStaticLabelEp()
        setDinamicLabelEp()
    }
    
    func setShadow() {
        addSubview(shadow)
        shadow.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(84)
            make.width.equalTo(322)
        }
        shadow.layer.masksToBounds = false
        shadow.layer.shadowOffset = CGSizeMake(0, 0)
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOpacity = 0.4
        shadow.layer.shadowRadius = 6
        shadow.backgroundColor = .white
    }
    
    func backMainViewSet() {
        addSubview(backMainView)
        backMainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(25)
            make.height.equalTo(94)
            make.width.equalTo(333)
        }
        backMainView.layer.cornerRadius = 10
        backMainView.layer.masksToBounds = true
        backMainView.backgroundColor = .white
    }
    
    func setImage() {
        addSubview(pictureHero)
        pictureHero.layer.masksToBounds = true
        pictureHero.layer.cornerRadius = 10
        pictureHero.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        pictureHero.snp.makeConstraints { make in
            make.top.equalTo(backMainView.snp.top)
            make.leading.equalTo(backMainView.snp.leading)
            make.height.equalTo(94)
            make.width.equalTo(94)
        }
    }
    
    func setNameHero() {
        addSubview(nameHero)
        let width = UIScreen.main.bounds.width - 50
        let height = ceil(nameHero.text?.height(
            withConstrainedWidth: width,
            font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 24) ?? .systemFont(ofSize: 24)) ?? 24)
        nameHero.snp.makeConstraints { make in
            make.top.equalTo(backMainView.snp.top).offset(7)
            make.leading.equalTo(backMainView.snp.leading).offset(100)
            make.trailing.equalTo(-25)
            make.height.equalTo(height)
        }
        nameHero.textColor = #colorLiteral(red: 1, green: 0.6838926673, blue: 0, alpha: 1)
        nameHero.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 22)
        nameHero.numberOfLines = 0
        nameHero.lineBreakMode = .byWordWrapping
        nameHero.preferredMaxLayoutWidth = 320
    }
    
    func setLabelLocation(){
        addSubview(labelLocation)
        labelLocation.textColor = .systemGray
        labelLocation.font = .boldSystemFont(ofSize: 12)
        labelLocation.numberOfLines = 0
        labelLocation.lineBreakMode = .byWordWrapping
        labelLocation.preferredMaxLayoutWidth = 310
        let width = UIScreen.main.bounds.width - 190
        let height = ceil(labelLocation.text?.height(
            withConstrainedWidth: width,
            font:.boldSystemFont(ofSize: 12)) ?? 12)
        labelLocation.snp.makeConstraints { make in
            make.top.equalTo(nameHero.snp.bottom).offset(7)
            make.leading.equalTo(nameHero.snp.leading)
            make.trailing.equalTo(-25)
            make.height.equalTo(height)
        }
    }
    
    func setStaticLabelEp() {
        addSubview(staticLabelEpisode)
        staticLabelEpisode.text = "Episode:"
        staticLabelEpisode.textColor = .systemGray
        staticLabelEpisode.font = .boldSystemFont(ofSize: 12)
        let width = UIScreen.main.bounds.width - 50
        let height = ceil(staticLabelEpisode.text?.height(
            withConstrainedWidth: width,
            font:.boldSystemFont(ofSize: 12)) ?? 12)
        staticLabelEpisode.snp.makeConstraints { make in
            make.top.equalTo(labelLocation.snp.bottom).offset(5)
            make.leading.equalTo(nameHero.snp.leading)
            make.trailing.equalTo(-25)
            make.height.equalTo(height)
        }
    }
    
    func setDinamicLabelEp() {
        addSubview(dinamicLabelEpisode)
        dinamicLabelEpisode.textColor = .systemGray
        dinamicLabelEpisode.font = .boldSystemFont(ofSize: 10)
        dinamicLabelEpisode.numberOfLines = 0
        dinamicLabelEpisode.lineBreakMode = .byWordWrapping
        dinamicLabelEpisode.preferredMaxLayoutWidth = 20
        let width = UIScreen.main.bounds.width - 190
        let height = ceil(dinamicLabelEpisode.text?.height(
            withConstrainedWidth: width,
            font:.boldSystemFont(ofSize: 10)) ?? 10)
        dinamicLabelEpisode.snp.makeConstraints { make in
            make.top.equalTo(staticLabelEpisode.snp.bottom).offset(2)
            make.leading.equalTo(nameHero.snp.leading)
            make.trailing.equalTo(-25)
            make.height.equalTo(height)
        }
    }
}




