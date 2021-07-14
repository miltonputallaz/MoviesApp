//
//  ConfigUtils.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 25/06/2021.
//

import Foundation

struct ConfigUtils {
    static func infoForKey(_ key: String) -> String? {
            return (Bundle.main.infoDictionary?[key] as? String)
     }
}
