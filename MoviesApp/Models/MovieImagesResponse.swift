//
//  MovieImagesResponse.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 18/07/2021.
//

import Foundation

struct MovieImagesResponse: Codable {
    var id: Int?
    var backdrops: [Image]?
    var posters: [Image]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case backdrops = "backdrops"
        case posters = "posters"
    }
}
