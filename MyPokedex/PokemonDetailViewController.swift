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
            self.namePokemon.text = pokemonpick.name
        }
    }
    
    @IBAction func BackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
