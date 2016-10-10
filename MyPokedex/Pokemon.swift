//
//  Pokemon.swift
//  MyPokedex
//
//  Created by Hermann Dorio on 10/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import Foundation

class Pokemon {
    fileprivate var _name:String!
    fileprivate var _pokeid:Int!
    
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
