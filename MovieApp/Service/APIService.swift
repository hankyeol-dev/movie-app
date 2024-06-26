//
//  APIService.swift
//  MovieApp
//
//  Created by 강한결 on 6/26/24.
//

import Foundation
import Alamofire

class APIService {
    private init() {}
    
    static let manager = APIService()
    
    private let base = BASE
    private let headers = HEADERS
    
    enum ServiceType {
        case currentPlaying
        case trend
        case topRated
        case searching(query: String)
        case detail(id: Int)
    }
    
    private func serviceEndPoint(_ type: ServiceType) -> String {
        switch type {
        case .currentPlaying:
            return "movie/now_playing"
        case .trend:
            return "trending/movie/day"
        case .topRated:
            return "movie/top_rated"
        case .searching(let query):
            return "search/movie?query=\(query)"
        case .detail(let id):
            return "movie/\(String(id))"
        }
    }
    
    private func serviceMethod(_ type: ServiceType) -> HTTPMethod {
        switch type {
        case .currentPlaying, .trend, .topRated, .searching, .detail:
            return .get
        }
    }
    
    private func genRequest(_ type: ServiceType) -> DataRequest {
        return AF.request(
            self.base + self.serviceEndPoint(type),
            method: self.serviceMethod(type),
            parameters: ["language": "ko-KR"],
            encoding: URLEncoding(destination: .queryString),
            headers: self.headers
        )
    }
    
    typealias SuccessHandler<T: Decodable> = (T) -> ()
    typealias ErrorHandler = (any Error) -> ()
    
    func fetch<T: Decodable>(_ type: ServiceType, successHandler: @escaping SuccessHandler<T>, errorHandler: @escaping ErrorHandler) {
        self.genRequest(type).responseDecodable(of: T.self) { response in
            do {
                let data = try response.result.get()
                successHandler(data)
            } catch {
                errorHandler(error)
            }
        }
    }
}
