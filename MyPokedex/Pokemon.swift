//
//  Pokemon.swift
//  MyPokedex
//
//  Created by Hermann Dorio on 10/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import Foundation

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
    
    var name:String {
        return _name
    }
    
    var pokeid:Int {
        return _pokeid
    }
    
    init(name: String, pokeid: Int) {
        self._name = name
        self._pokeid = pokeid
    }
}
