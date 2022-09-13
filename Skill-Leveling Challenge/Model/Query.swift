//
//  Query.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 12-09-22.
//

import Foundation

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
