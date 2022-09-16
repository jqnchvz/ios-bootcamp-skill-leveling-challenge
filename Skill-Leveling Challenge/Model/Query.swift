//
//  Query.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 12-09-22.
//

import Foundation
import CoreImage

struct HighlightQuery: Codable {
    let query_data: QueryData
    let content: [QueryItem]
}

struct QueryData: Codable {
    let highlight_type: String
    let criteria: String
    let id: String
}

struct QueryItem: Codable {
    let id: String
    let position: Int
    let type: String
}


typealias MultigetQuery = [MultigetQueryItem]

struct MultigetQueryItem: Codable {
    let code: Int
    let body: MultigetQueryItemDetails
}

struct MultigetQueryItemDetails: Codable {
    let id: String
    let title: String
    let secure_thumbnail: String
    let price: Int
    let seller_address: Address
    let condition: String
    let pictures: [Picture]
    
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedPrice = formatter.string(from: price as NSNumber) {
            return formattedPrice
        }
        return "Precio No Válido"
    }
    
    
    struct Address: Codable {
        let city: City
        let state: State
        let country: Country
        
        struct City: Codable {
            let name: String
        }
        
        struct State: Codable {
            let name: String
        }
        
        struct Country: Codable {
            let name: String
        }
        
        var formattedLocation: String {
            return city.name.capitalized + ", " + state.name.capitalized + ", " + country.name.capitalized
        }
    }
    
    struct Picture: Codable {
        let id : String
        let secure_url: String
    }
}

struct Description: Codable {
    let plain_text: String
}
