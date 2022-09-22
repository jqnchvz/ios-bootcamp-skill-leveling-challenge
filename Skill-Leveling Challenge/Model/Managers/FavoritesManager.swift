//
//  FavoritesManager.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 19-09-22.
//

import Foundation

// MARK: Favorites Manager

class FavoritesManager {
    
    private(set) var favoritesIds: [String] = []
    
    private let userDefaults = UserDefaults.standard
    
    static let shared = FavoritesManager()
    
    private init() {}
    
    // Load favorites list from UserDefaults
    func loadFavorites() {
        if let loadedFavorites = userDefaults.stringArray(forKey: "FavoriteItems") {
            print("Loading favorites...")
            favoritesIds = loadedFavorites
            print("Favorites list loaded!")
        }
    }
    
    // Save favorites list to UserDefaults
    func saveFavorites() {
        print("Saving favorites...")
        userDefaults.set(favoritesIds, forKey: "FavoriteItems")
        print("Favorites list saved!")
        loadFavorites()
    }
    
    // Add item ID to favorites list
    func addItemToFavorites(_ itemId: String) {
        self.favoritesIds.append(itemId)
        saveFavorites()
    }
    
    // Add remove ID to favorites list
    func removeItemFromFavorites(_ itemId: String) {
        guard let itemIdIndex = favoritesIds.firstIndex(of: itemId) else { return }
        self.favoritesIds.remove(at: itemIdIndex)
        saveFavorites()
    }
}
