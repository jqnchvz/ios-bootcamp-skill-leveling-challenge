//
//  FavoritesManager.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 19-09-22.
//

import Foundation

class FavoritesManager {
    
    var favoritesIds: [String] = []
    
    let userDefaults = UserDefaults.standard
    
    static let shared = FavoritesManager()
    
    private init() {}
    
    func loadFavorites() {
        if let loadedFavorites = userDefaults.stringArray(forKey: "FavoriteItems") {
            print("Loading favorites...")
            favoritesIds = loadedFavorites
            print("Favorites list loaded!")
        }
    }
    
    func saveFavorites(_ favoritesArray: [String]) {
        print("Saving favorites...")
        userDefaults.set(favoritesArray, forKey: "FavoriteItems")
        print("Favorites list saved!")
        loadFavorites()
    }
}
