//
//  Category.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 12-09-22.
//

import Foundation

typealias Categories = [Category]
struct Category: Codable {
    
    let domain_id: String
    let domain_name: String
    let category_id: String
    let category_name: String
    
}
