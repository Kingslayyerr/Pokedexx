//
//  Pokemon.swift
//  Pokedexx
//
//  Created by christian espinoza on 1/31/17.
//  Copyright © 2017 Christian Espinoza. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    // getters
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    // setter or initializer
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}

// Pokemon(name: Growlith, pokedexId: 67573)

// Pokemon.name
// Pokemon.pokedexId
