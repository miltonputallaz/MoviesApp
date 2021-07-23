//
//  Image.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 18/07/2021.
//

import Foundation

struct Image: Codable {
    var aspectRatio: Double?
    var filePath: String?
    var height: Int?
    var iso6391: String?
    var voteAverage: Int?
    var voteCount: Int?
    var width: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height = "height"
        case iso6391 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width = "width"
    }
}
