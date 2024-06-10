//
//  Genre.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import Foundation
import Alamofire

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct Genres: Decodable {
    let genres: [Genre]
}

func mappingGenre(genresDB: [Genre], targetGenres: [Int]) -> String {
    return targetGenres.enumerated().map { (idx, el) in
        return genresDB.filter {
            return $0.id == el
        }[0].name
    }.map {
        "#" + $0
    }.joined(separator: " ")
}
