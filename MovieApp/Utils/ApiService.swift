//
//  Helper+Apis.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import Alamofire

class ApiService {
    private init() {}
    
    @frozen enum ServiceType {
        case current
        case topRate
        case popularity
        case recommend
        case genre
    }
    
    static let service = ApiService()
    
    func fetch(_ type: ServiceType) {
        
    }
    
    private func mappingURL(_ type: ServiceType, movieId: Int?) -> String {
        switch type {
        case .current:
            return "https://api.themoviedb.org/3/movie/now_playing?language=ko-KR"
        case .topRate:
            return "https://api.themoviedb.org/3/movie/top_rated?language=ko-KR"
        case .popularity:
            return "https://api.themoviedb.org/3/movie/popular?language=ko-KR"
        case .recommend:
            guard let movieId else { return "" }
            return "https://api.themoviedb.org/3/movie/\(String(movieId))/recommendations"
        case .genre:
            return ""
        }
    }
}
