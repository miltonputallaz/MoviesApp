//
//  ListResponse.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 30/06/2021.
//

import Foundation

struct ListResponse<T>: Decodable where T: Decodable{
    var page: Int?
    var results: [T]?
    var totalResults: Int?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
