//
//  Trend.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let backdrop_path: String
    let poster_path: String
    let genre_ids: [Int]
    let title: String
    let release_date: String
    let vote_average: Double
    
    var formattedVoteAvg: String {
        return String(format: "%.1f", vote_average)
    }
}

struct MovieDetail: Decodable {
    let backdrop_path: String
    let poster_path: String
    let title: String
    let overview: String
}

struct MovieResult: Decodable {
    let results: [Movie]
}
