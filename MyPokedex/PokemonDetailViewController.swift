//
//  PokemonDetailViewController.swift
//  MyPokedex
//
//  Created by Hermann Dorio on 11/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon:Pokemon?
    
    @IBOutlet weak var idPokemon: UILabel!
    @IBOutlet weak var levelEvolution: UILabel!
    @IBOutlet weak var imagePokemonBase: UIImageView!
    @IBOutlet weak var imageEvolutionPokemon: UIImageView!
    @IBOutlet weak var defensePokemon: UILabel!
    @IBOutlet weak var attackPokemon: UILabel!
    @IBOutlet weak var HeightPokemon: UILabel!
    @IBOutlet weak var weightPokemon: UILabel!
    @IBOutlet weak var typePokemon: UILabel!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var descriptionPokemon: UILabel!
    @IBOutlet weak var myimagePokemon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pokemonpick = pokemon  {
            pokemonpick.downloadPokemonDetails {
                self.updateUI()
            }
        }
    }
    
    @IBAction func BackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        if (pokemon!.nextEvolution != ""){
            self.levelEvolution.text = "Next Evolution \(pokemon!.nextEvolution) : LVL \(pokemon!.LevelEvolution)"
            self.imageEvolutionPokemon.image = UIImage(named: pokemon!.idNextEvolution)
            self.imageEvolutionPokemon.isHidden = false
        }else{
            self.imageEvolutionPokemon.isHidden = true
            self.levelEvolution.text = "No Evolution"
        }
        self.namePokemon.text = pokemon?.name
        self.imagePokemonBase.image = UIImage(named: "\(pokemon!.pokeid)")
        self.myimagePokemon.image = UIImage(named: "\(pokemon!.pokeid)")
        self.attackPokemon.text = pokemon!.attack
        self.defensePokemon.text = pokemon!.defense
        self.descriptionPokemon.text = pokemon!.description
        self.weightPokemon.text = pokemon!.weight
        self.HeightPokemon.text = pokemon!.height
        self.typePokemon.text = pokemon!.type
        self.idPokemon.text = "\(pokemon!.pokeid)"
    }
    
}
