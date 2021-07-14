//
//  Genre.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 14/07/2021.
//

import Foundation

struct Genre: Codable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
