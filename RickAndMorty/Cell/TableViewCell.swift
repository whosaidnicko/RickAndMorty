//
//  TableViewCell.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 15/03/2023.
//

import UIKit


class TableViewCell: UITableViewCell{
    
    lazy var nameHero = UILabel()
    lazy var  pictureHero = UIImageView()
    lazy var entireView = UIView()
    lazy  var yo  = UILabel()
    lazy var shadow = UIView()
    lazy var backMainView = UIView()
    lazy var labelLocation = UILabel()
    lazy var staticLabelEpisode = UILabel()
    lazy var dinamicLabelEpisode = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setShadow()
        backMainViewSet()
        setImage()
        setLabel()
        setLabelLocation()
        setStaticLabelEp()
        setDinamicLabelEp()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setLabel() {
        
        nameHero.layer.frame = CGRect(x: 120, y: 28, width: 300, height: 30)
        nameHero.textColor = #colorLiteral(red: 1, green: 0.6838926673, blue: 0, alpha: 1)

        
        
        nameHero.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)
        
        addSubview(nameHero)
    }
    
    func setImage() {
        pictureHero.layer.frame = CGRect(x: 25, y: 23, width: 85, height: 94)
        pictureHero.layer.masksToBounds = true
        pictureHero.layer.cornerRadius = 10
        pictureHero.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        addSubview(pictureHero)
    }
    
    
    func setShadow() {
        shadow.layer.frame = CGRect(x: 32, y: 26, width: 320 , height: 87)
        shadow.layer.masksToBounds = false
        shadow.layer.shadowOffset = CGSizeMake(0, 0)
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOpacity = 0.4
        shadow.layer.shadowRadius = 10
        shadow.backgroundColor = .white
        addSubview(shadow)
    }
    func backMainViewSet() {
        backMainView.layer.frame = CGRect(x: 25, y: 23, width: 330, height: 94)
        backMainView.backgroundColor = .white
        backMainView.layer.cornerRadius = 10
        backMainView.layer.masksToBounds = true
        addSubview(backMainView)
    }
    
    func setLabelLocation(){
        labelLocation.layer.frame = CGRect(x: 120, y: 53, width: 250, height: 30)
        labelLocation.textColor = .systemGray
        labelLocation.font = .boldSystemFont(ofSize: 14)
        addSubview(labelLocation)
        
    }
    
    func setStaticLabelEp() {
        staticLabelEpisode.text = "Episode:"
        staticLabelEpisode.layer.frame = CGRect(x: 120, y: 48, width: 80, height: 80)
        staticLabelEpisode.textColor = .systemGray
        staticLabelEpisode.font = .boldSystemFont(ofSize: 10)
        addSubview(staticLabelEpisode)
        
    }
    func setDinamicLabelEp() {
        dinamicLabelEpisode.layer.frame = CGRect(x: 120, y: 59, width: 170, height: 80)
        
        
        dinamicLabelEpisode.textColor = .systemGray
        dinamicLabelEpisode.font = .boldSystemFont(ofSize: 10)
        addSubview(dinamicLabelEpisode)
        
    }
}




