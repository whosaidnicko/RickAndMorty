//
//  TableViewCell.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 15/03/2023.
//

import UIKit


class TableViewCell: UITableViewCell{
    
    var result: Result? {
        didSet {
            configureCell()
        }
    }

    @IBOutlet weak var nameHero: UILabel!
    @IBOutlet weak var pictureHero: UIImageView!
    @IBOutlet weak var entireView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        entireView.backgroundColor = .red
        pictureHero.image = UIImage(systemName: "star")
        pictureHero.backgroundColor = .red
   
        
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
     
     
    }
    func configureCell()  {
        if let name = result?.name {
            nameHero.text = name
        }
    }
    
}



