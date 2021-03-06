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
    fileprivate var _nextEvolutionName: String!
    fileprivate var _nextEvolutionId: String!
    fileprivate var _nextEvolutionLvl: String!
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
    var nextEvolutionName: String { if _nextEvolutionName == nil { _nextEvolutionName = "" }; return _nextEvolutionName }
    var nextEvolutionId: String { if _nextEvolutionId == nil { _nextEvolutionId = "" }; return _nextEvolutionId }
    var nextEvolutionLvl: String { if _nextEvolutionLvl == nil { _nextEvolutionLvl = "" }; return _nextEvolutionLvl }
    var pokemonURL: String { if _pokemonURL == nil { _pokemonURL = "" }; return _pokemonURL }
    
    
    init(name: String, pokedexId: Int) {
        self._name = name.capitalized
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
                if let types   = dict["types"] as? [Dictionary<String,String>], types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                if let descArray = dict["descriptions"] as? [Dictionary<String,String>], descArray.count > 0 {
                    if let url = descArray[0]["resource_uri"] {
                        let descURL = "\(URL_BASE)\(url)"
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
//                                    print(description)
                                    self._description = newDescription
//                                    print("set self._description to \(self._description)")
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = "No description"
                }
                
                if let evoArray = dict["evolutions"] as? [Dictionary<String,AnyObject>], evoArray.count > 0 {
                    if let nextEvo = evoArray[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvo
                            if let uri = evoArray[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = nextEvoId
                                
                                if let lvlExist = evoArray[0]["level"] {
                                    if let lvl = lvlExist as? Int {
                                        self._nextEvolutionLvl = "\(lvl)"
                                    }
                                } else {
                                    self._nextEvolutionLvl = ""
                                }
                            }
                        }
                    }
                }
                
//                print(self._name)
//                print(self._weight)
//                print(self._height)
//                print(self._attack)
//                print(self._defense)
//                print(self._type)
//                print("self._description is \(self._description)")
//                print("\n")
                print(self._nextEvolutionLvl)
                print(self._nextEvolutionId)
                print(self._nextEvolutionName)
                print(self._nextEvolutionTxt)
            }
            
            completed()
            
        }
        
    }
}
