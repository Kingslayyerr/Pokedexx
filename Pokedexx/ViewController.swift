//
//  ViewController.swift
//  Pokedexx
//
//  Created by christian espinoza on 1/31/17.
//  Copyright © 2017 Christian Espinoza. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
      collection.dataSource = self
      collection.delegate = self
      searchBar.delegate = self
        
      searchBar.returnKeyType = UIReturnKeyType.done
        
      parsePokemonCSV()
      initAudio()
        
    }
    
    // plays music->
    func initAudio() {
        let path = Bundle.main.path(forResource: "goldsun", ofType: "mp3")!
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }
    
    // function that makes use of csv.swift to parse through pokemon.csv our data source ->
    func parsePokemonCSV() {
        
        // creates a path to the Pokemon.csv file->
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            // using the parser to pull out the rows
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            // go through each row->
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                // create an object called poke->
                let poke = Pokemon(name: name, pokedexId: pokeId)
                // add it to the array we created->
                pokemon.append(poke)
            }
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
        
    }
    
    // Dequeues cell when it is off screen to speed upp app perfomance ->
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
            } else {
                poke = pokemon[indexPath.row]
                cell.configureCell(poke)
            }
            
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    // Decides what happens when the cell is clicked/selected ->
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailsVC", sender: poke)
    }
    
    // Decides how many cells will be available ->
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            
          return filteredPokemon.count
        }
        
       return pokemon.count
    }
    
    // Decides how many cell views(cell container we only need 1) will be available ->
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Decides the size of the cells ->
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func musicButton(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil })
            collection.reloadData()
        }
    }
    
    
    // Prepares and sets up the segueway
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailsVC" {
            if let detailsVC = segue.destination as? PokemonDetailsVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
}

