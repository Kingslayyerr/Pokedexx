//
//  PokemonDetailsVC.swift
//  Pokedexx
//
//  Created by christian espinoza on 2/3/17.
//  Copyright © 2017 Christian Espinoza. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabl.text = pokemon.name

    }

 
}
