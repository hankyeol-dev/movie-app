//
//  UserDefaultService.swift
//  MovieApp
//
//  Created by 강한결 on 6/26/24.
//

import Foundation

class UserDefaultService {
    private init() {}
    private let standard = UserDefaults.standard
    private let key = "ratedMovie"
    
    static let manager = UserDefaultService()
    
    private var isInUserDefaults: Bool {
        return self.standard.object(forKey: self.key) != nil
    }
    
    private func isRatedMovieById(movieId: Int) -> Bool {
        if self.isInUserDefaults {
            let movies = self.getRatedMovies()
            return movies.filter { $0.id == movieId }.count != 0
        }
        
        return false
    }
    
    func getMovieRateById(movieId: Int) -> Int {
        return self.isRatedMovieById(movieId: movieId) ? self.getRatedMovieById(movieId).rate : 0
    }
    
    
    /**
     UserDefaults에 저장된 평가한 영화 정보 리스트를 가져오는 API
     */
    func getRatedMovies() -> [RatedMovie] {
        if !self.isInUserDefaults {
            return []
        } else {
            return try! JSONDecoder().decode(RatedMovies.self, from: self.standard.object(forKey: self.key) as! Data).list
        }
    }
    
    private func getRatedMovieById(_ movieId: Int) -> RatedMovie {
        if self.isRatedMovieById(movieId: movieId) {
            return self.getRatedMovies().filter { $0.id == movieId }[0]
        }
        
        return RatedMovie(id: movieId)
    }
    
    
    /**
     UserDefaults에 평가한 영화 정보를 저장하는 API
     */
    func saveRatedMovies(movieId: Int, rating: Int) {
        var notInTargetMovies = self.getRatedMovies().filter { $0.id != movieId }
        var targetMovie = self.getRatedMovieById(movieId)

        if rating != 0  {
            targetMovie.rate = rating
            notInTargetMovies.append(targetMovie)
        }
        
        if let data = try? JSONEncoder().encode(RatedMovies(list: notInTargetMovies)) {
            self.standard.set(data, forKey: self.key)
        }
    }

}
