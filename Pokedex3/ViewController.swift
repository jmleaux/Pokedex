//
//  ViewController.swift
//  Pokedex3
//
//  Created by J. M. Lowe on 6/2/17.
//  Copyright © 2017 JMLeaux LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let charmander = Pokemon(name: "charmander", pokedexId: 4)
        
        collection.dataSource = self
        collection.delegate = self
        
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        dequeueReusableCell is used to avoid loading every Pokemon item at once; this loads only enough to fill the collection on the screen
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon = Pokemon(name: "Pokemon", pokedexId: indexPath.row + 1)
                // "+ 1" above because there is no pokemon with id=0
            cell.configureCell(pokemon: pokemon)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
//    code below handles what happens when users taps on a collection view cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
//    code below sets number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    
//    code below sets number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
//    code below sets size of the individual cells in the collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: 105, height: 105)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

