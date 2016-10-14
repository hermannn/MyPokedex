//
//  ViewController.swift
//  MyPokedex
//
//  Created by Hermann Dorio on 10/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var searchbar: UISearchBar!
    var pokemons = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    @IBOutlet weak var mycollection: UICollectionView!
    var inSearchMode = false
    var audio:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchbar.delegate = self
        self.mycollection.delegate = self
        self.mycollection.dataSource = self
        parseCSV()
        initSound()
        searchbar.returnKeyType = UIReturnKeyType.done
    }
    
    func initSound () {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do{
            let url = URL(fileURLWithPath: path!)
            audio = try AVAudioPlayer(contentsOf: url)
            audio.prepareToPlay()
            audio.numberOfLoops = -1
            audio.play()
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parseCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csvparser = try CSV(contentsOfURL: path)
            let rows = csvparser.rows
            for row in rows {
              let name = row["identifier"]
              let id = (row["id"]! as NSString).integerValue
              let pokemon = Pokemon(name: name!, pokeid: id)
              pokemons.append(pokemon)
            }
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var pokemonpick:Pokemon!
        
        if (inSearchMode == false){
            pokemonpick = pokemons[indexPath.row]
        }else{
            pokemonpick = filteredPokemon[indexPath.row]
        }
        performSegue(withIdentifier: "PokemonDetail", sender: pokemonpick)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetail" {
            if let destination = segue.destination as?  PokemonDetailViewController {
                if let pokemon = sender as? Pokemon {
                    destination.pokemon = pokemon
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (inSearchMode == false){
            return pokemons.count
        }else{
            return filteredPokemon.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = mycollection.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            if (inSearchMode == false){
                cell.updateUI(pokemons[indexPath.row])
            }else{
                cell.updateUI(filteredPokemon[indexPath.row])
            }
            return cell
        }
        return UICollectionViewCell ()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

    @IBAction func MusicPressed(_ sender: UIButton) {
        if (audio.isPlaying){
            audio.stop()
            sender.alpha = 0.6
        }else {
            audio.play()
            sender.alpha = 1
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchbar.text == "" || searchbar == nil){
            self.view.endEditing(true)
            self.inSearchMode = false
            mycollection.reloadData()
        }
        else{
            self.inSearchMode =  true
            let lower = searchbar.text!.lowercased()
            filteredPokemon = pokemons.filter({$0.name.range(of: lower) != nil})
            mycollection.reloadData()
        }
        
    }

}

