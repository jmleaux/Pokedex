//
//  PokeCell.swift
//  Pokedex3
//
//  Created by J. M. Lowe on 6/3/17.
//  Copyright © 2017 JMLeaux LLC. All rights reserved.
//

import UIKit


class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    
//    init code below is used to round the corners of the individual cells in the collection
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(_ pokemon: Pokemon) {
//        self.pokemon = pokemon
//        nameLbl.text = self.pokemon.name.capitalized
//        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
        // JML: I don't know why the code above defines 'self.pokemon' then references it...instead of the pokemon instance that was passed to it...so I'm taking it out to see if this works...
        
        nameLbl.text = pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(pokemon.pokedexId)")

    }
}
