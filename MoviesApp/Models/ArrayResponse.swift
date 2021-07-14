//
//  ArrayResult.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 14/07/2021.
//

import Foundation

struct ArrayResponse<T>: Decodable where T: Decodable{
    var genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
}
