//
//  Pokemon.swift
//  Pokedex3
//
//  Created by J. M. Lowe on 6/2/17.
//  Copyright © 2017 JMLeaux LLC. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _attack: String!
    fileprivate var _nextEvolutionTxt: String!
    fileprivate var _pokemonURL: String!
    
    
// these are "getters" and "setters" to ensure the code doesn't fail due to unexpected nil values
    
    var name: String { return _name }
    var pokedexId: Int { return _pokedexId }
    var description: String {if _description == nil { _description = "" }; return _description }
    var type: String { if _type == nil { _type = "" }; return _type }
    var defense: String { if _defense == nil { _defense = "" }; return _defense }
    var height: String {if _height == nil { _height = "" }; return _height }
    var weight: String { if _weight == nil { _weight = "" }; return _weight }
    var attack: String { if _attack == nil { _attack = "" };  return _attack }
    var nextEvolutionText: String { if _nextEvolutionTxt == nil { _nextEvolutionTxt = "" } ; return _nextEvolutionTxt }
    var pokemonURL: String { if _pokemonURL == nil { _pokemonURL = "" }; return _pokemonURL }
    
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
//        print("self._pokemonURL is \(self._pokemonURL)")
        
        
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
//            print(response.result.value!)
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight  = dict["weight"]  as? String { self._weight = weight }
                if let height  = dict["height"]  as? String { self._height = height }
                if let attack  = dict["attack"]  as? Int { self._attack = "\(attack)" }
                if let defense = dict["defense"] as? Int { self._defense = "\(defense)" }
                
                print(self._name)
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                print("\n")
            }
            
            completed()
            
        }
        
    }
}
