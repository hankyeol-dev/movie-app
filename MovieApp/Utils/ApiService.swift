//
//  Helper+Apis.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import Alamofire

class ApiService {
    private init() {}
    
    @frozen enum ServiceType: String, CaseIterable {
        case current = "현재 상영작"
        case topRate = "역대 최고 평가"
        case popularity = "역대 최고 인기"
        case recommend = "연관 추천 영화"
    }
    
    static let manager = ApiService()
    
    func fetch<T: Decodable>(_ type: ServiceType, movieId: Int?, successHandler: @escaping (T) -> ()) {
        AF.request(mappingURL(type, movieId: movieId), headers: API_HEADERS).responseDecodable(of: T.self) { res in
            switch res.result {
            case .success(let v):
                successHandler(v)
            case .failure(let e):
                print(e)
            }
        }
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
        }
    }
}
