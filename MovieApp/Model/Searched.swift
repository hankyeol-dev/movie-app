//
//  Searched.swift
//  MovieApp
//
//  Created by 강한결 on 6/11/24.
//

import Foundation

struct Searched: Decodable  {
    let title: String
    let poster_path: String?
    let vote_average: Double
}

struct SearchedResult: Decodable {
    let page: Int
    let total_pages: Int
    let results: [Searched]
}

