//
//  Credit.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import Foundation

struct Cast: Decodable {
    let name: String
    let profile_path: String?
    let character: String
}

struct Credit: Decodable {
    let cast: [Cast]
    
    var formattedCastName: String {
        return cast.map {
            $0.name
        }.joined(separator: ", ")
    }
}

