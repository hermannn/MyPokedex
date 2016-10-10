//
//  ViewController.swift
//  MyPokedex
//
//  Created by Hermann Dorio on 10/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var searchbar: UISearchBar!
    var pokemons = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    @IBOutlet weak var mycollection: UICollectionView!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mycollection.delegate = self
        self.mycollection.dataSource = self
        parseCSV()
    }
    
    func parseCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csvparser = try CSV(contentsOfURL: path)
            let rows = csvparser.rows
            print(rows)
            /*for row in rows {
                
            }*/
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (inSearchMode == false){
            return pokemons.count
        }else{
            return filteredPokemon.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell ()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

    @IBAction func MusicPressed(_ sender: UIButton) {
    }

}

