//
//  GenreService.swift
//  MovieApp
//
//  Created by 강한결 on 6/26/24.
//

import Foundation

class GenreOutput {
    let status: Bool
    let data: Genre?
    
    init(status: Bool, data: Genre?) {
        self.status = status
        self.data = data
    }
}

class GenreService {
    private let genres: [Genre] = [(28, "액션"), (12, "어드벤처"), (16, "애니메이션"), (35, "코미디"), (80, "범죄"), (99, "다큐멘터리"), (18, "드라마"), (10751, "가족"), (14, "판타지"), (36, "역사"), (27, "호러"), (10402, "음악"), (9648, "미스터리"), (10749, "로맨스"), (878, "SF"), (10770, "TV Movie"), (53, "스릴러"), (10752, "전쟁"), (37, "서부")].map {
        Genre(id: $0.0, name: $0.1)
    }
    
    private init() {}
    
    static let manager = GenreService()
    
    private func isInGenres(_ id: Int) -> Bool {
        return genres.filter {
            $0.id == id
        }.count != 0
    }
    
    func getGenres() -> [Genre] {
        return genres
    }
    
    func getGenreById(_ id: Int) -> GenreOutput {
        if !isInGenres(id) {
            return GenreOutput(status: false, data: nil)
        } else {
            return GenreOutput(status: true, data: genres.filter {
                $0.id == id
            }[0])
        }
    }
    
    func getGenresByIds(_ ids: [Int]) -> [GenreOutput] {
        return ids.map {
            self.getGenreById($0)
        }.filter {
            !$0.status
        }
    }
}
