//
//  PokeCell.swift
//  MyPokedex
//
//  Created by Hermann Dorio on 11/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var myname: UILabel!
    @IBOutlet weak var myimage: UIImageView!
    
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func updateUI(_ pokemon: Pokemon){
        self.myname.text = pokemon.name
        self.myimage.image = UIImage(named: "\(pokemon.pokeid)")
    }
}
