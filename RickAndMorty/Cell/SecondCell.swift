//
//  SecondViewController.swift
//  RickAndMorty
//
//  Created by Nicolae Chivriga on 02/04/2023.
//

import UIKit

class SecondCell: UITableViewCell {
    
    let nameHero = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameHero.text = "Hello"
        nameHero.layer.frame = CGRect(x: 0, y: 0, width: 300, height: 15)

     addSubview(nameHero)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
