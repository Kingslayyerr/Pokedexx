//
//  Pokemon.swift
//  Pokedexx
//
//  Created by christian espinoza on 1/31/17.
//  Copyright © 2017 Christian Espinoza. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    
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


// Example usage:

// Pokemon(name: "Growlith", pokedexId: 100) <- Setter/Initializer
// Pokemon.name <- Getter(retrieves data)
// Pokemon.pokedexId <- Getter(retrieves data)
