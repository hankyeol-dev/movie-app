//
//  Trend.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import Foundation

struct RatedMovie: Codable {
    let id: Int
    var rate: Int = 0
}

struct RatedMovies: Codable {
    let list: [RatedMovie]
}

struct Movie: Decodable {
    let id: Int
    let backdrop_path: String
    let poster_path: String
    let genre_ids: [Int]
    let title: String
    let release_date: String
    let vote_average: Double
    let overview: String
    
    var formattedVoteAvg: String {
        return String(format: "%.1f", vote_average)
    }
}

struct MovieDetail: Decodable {
    let id: Int
    let backdrop_path: String
    let poster_path: String
    let genres: [Genre]
    let title: String
    let release_date: String
    let vote_average: Double
    let overview: String
    
    var formattedVoteAvg: String {
        return String(format: "%.1f", vote_average)
    }
    
    var forMovieDetailHeaders: MovieDetailHeaderData {
        return MovieDetailHeaderData(
            backdrop: ImageBaseURL.BACKGROUND.rawValue + backdrop_path,
            poster: ImageBaseURL.POSTER.rawValue + poster_path ,
            title: title,
            release_date: release_date,
            genres: GenreService.manager.formattingGenres(genres)
        )
    }
}

struct MovieCast: Decodable {
    let name: String
    let character: String
    let order: Int
    var profile_path: String? = ""
}

struct MovieCrew: Decodable {
    let name: String
    let job: String
    var profile_path: String? = ""
}

struct MovieResult: Decodable {
    let results: [Movie]
    
    var getFiveRecommends: [Movie] {
        var movie: [Movie] = []
        for i in 0..<5 {
            movie.append(results[i])
        }
        return movie
    }
}

struct MovieCastResult: Decodable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
    
    var getDirector: MovieCrew {
        return crew[0]
    }
    
    var getFiveActors: [MovieCast] {
        var casting: [MovieCast] = []
        for i in 0..<5 {
            casting.append(cast[i])
        }
        return casting
    }
}

struct MovieDetailHeaderData {
    let backdrop: String
    let poster: String
    let title: String
    let release_date: String
    let genres: String
}
