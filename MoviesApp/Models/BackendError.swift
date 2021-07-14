//
//  BackendError.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 02/07/2021.
//

import Foundation

struct BackendError: Codable {
    
    var statusMessage: String?
    var statusCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }

}
