//
//  Pokemon.swift
//  MyPokedex
//
//  Created by Hermann Dorio on 10/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name:String!
    private var _pokeid:Int!
    private var _description:String!
    private var _defense:String!
    private var _attack:String!
    private var _height:String!
    private var _weight:String!
    private var _type:String!
    private var _nextEvolution:String!
    private var _LevelEvolution:String!
    private var _idNextEvolution:String!
    
    var name:String {
        if (_name == nil){
            _name = ""
        }
        return _name
    }
    
    var pokeid:Int {
        if (_pokeid == nil){
            _pokeid = 0
        }
        return _pokeid
    }
   
    var LevelEvolution:String {
        if (_LevelEvolution == nil){
            _LevelEvolution = ""
        }
        return _LevelEvolution
    }

    var idNextEvolution:String {
        if (_idNextEvolution == nil){
            _idNextEvolution = ""
        }
        return _idNextEvolution
    }

    
    var description:String {
        if (_description == nil){
            _description = ""
        }
        return _description
    }
    
    var defense:String {
        if (_defense == nil){
            _defense = ""
        }
        return _defense
    }
    
    var attack:String {
        if (_attack == nil){
            _attack = ""
        }
        return _attack
    }
    
    var height:String {
        if (_height == nil){
            _height = ""
        }
        return _height
    }
    
    var weight:String {
        if (_weight == nil){
            _weight = ""
        }
        return _weight
    }
    
    var type:String {
        if (_type == nil){
            _type = ""
        }
        return _type
    }
    
    var nextEvolution:String {
        if (_nextEvolution == nil){
            _nextEvolution = ""
        }
        return _nextEvolution
    }

    
    init(name: String, pokeid: Int) {
        self._name = name
        self._pokeid = pokeid
    }
    
    func downloadPokemonDetails (completed: @escaping DownloadCompleted) {
        let urlcomplete = "\(BASE_URL)\(GETPOKEMON)\(pokeid)"
        let url  = URL(string: urlcomplete)!
        
        Alamofire.request(url).responseJSON { (response) in
            print(response.result.value)
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                
                self.DLStat(dict: dict)
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, AnyObject>]  {
                    if let urldescription = descriptions[0]["resource_uri"] as? String {
                        let urltoGetDescription = "\(BASE_URL)\(urldescription)"
                        Alamofire.request(urltoGetDescription).responseJSON{ (response) in
                            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = dict["description"] as? String {
                                    self._description = description
                                }
                            }
                            completed()
                        }
                    }
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    self.DlEvolution(evolutions: evolutions)
                }
                
                if let types = dict["types"] as? [Dictionary<String, AnyObject>], types.count > 0 {
                    var fulltype = ""
                    for type in types {
                        if let nametype = type["name"] as? String {
                            fulltype += "\(nametype)/"
                        }
                    }
                    self._type = fulltype
                    self._type.remove(at: self._type.index(before: self._type.endIndex))
                }
                
            }
            completed()
        }
        
    }
    
    func DlEvolution(evolutions: [Dictionary<String, AnyObject>]) {
            if let level = evolutions[0]["level"] as? Int {
                self._LevelEvolution = "\(level)"
            }
            
            if let nameEvolution = evolutions[0]["to"] as? String {
                if nameEvolution.contains("mega") == false {
                    self._nextEvolution = nameEvolution
                }
            }
            
            if let idEvolution = evolutions[0]["resource_uri"] as? String {
                let parseString = idEvolution.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                let idString = parseString.replacingOccurrences(of: "/", with: "")
                
                self._idNextEvolution = idString
            }
    }
    
    
    func DLStat(dict: Dictionary<String, AnyObject>) {
        if let name = dict["name"] as? String {
            self._name = name
        }
        if let height = dict["height"] as? String{
            self._height = height
        }
        
        if let weight = dict["weight"] as? String{
            self._weight = weight
        }
        
        if let attack = dict["attack"] as? Int{
            self._attack = "\(attack)"
        }
        
        if let defense = dict["defense"] as? Int{
            self._defense = "\(defense)"
        }

    }
    
    
}
