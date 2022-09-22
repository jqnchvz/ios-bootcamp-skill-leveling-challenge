//
//  FavoritesManager.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 19-09-22.
//

import Foundation

class FavoritesManager {
    
    private(set) var favoritesIds: [String] = []
    
    private let userDefaults = UserDefaults.standard
    
    static let shared = FavoritesManager()
    
    private init() {}
    
    func loadFavorites() {
        if let loadedFavorites = userDefaults.stringArray(forKey: "FavoriteItems") {
            print("Loading favorites...")
            favoritesIds = loadedFavorites
            print("Favorites list loaded!")
        }
    }
    
    func saveFavorites() {
        print("Saving favorites...")
        userDefaults.set(favoritesIds, forKey: "FavoriteItems")
        print("Favorites list saved!")
        loadFavorites()
    }
    
    func addItemToFavorites(_ itemId: String) {
        self.favoritesIds.append(itemId)
        saveFavorites()
    }
    
    func removeItemFromFavorites(_ itemId: String) {
        guard let itemIdIndex = favoritesIds.firstIndex(of: itemId) else { return }
        self.favoritesIds.remove(at: itemIdIndex)
        saveFavorites()
    }
}
