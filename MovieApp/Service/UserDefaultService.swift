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
        return standard.array(forKey: self.key) != nil
    }
    
    private func isRatedMovieById(movieId: Int) -> Bool {
        if self.isInUserDefaults {
            let array = self.standard.array(forKey: self.key) as! [RatedMovie]
            return array.filter { $0.id == movieId }.count != 0
        } 
        
        return false
    }
    
    func getMovieRateById(movieId: Int) -> Int {
        return self.isRatedMovieById(movieId: movieId) ? self.getRatedMovies().filter {
            $0.id == movieId
        }[0].rate : 0
    }
    
    
    /**
     UserDefaults에 저장된 평가한 영화 정보 리스트를 가져오는 API
     */
    func getRatedMovies() -> [RatedMovie] {
        if !self.isInUserDefaults {
            return []
        } else {
            return self.standard.array(forKey: self.key) as! [RatedMovie]
        }
    }
    
    
    /**
     UserDefaults에 평가한 영화 정보를 저장하는 API
     */
    func saveRatedMovies() {
        
    }
}
