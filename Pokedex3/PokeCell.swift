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
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
