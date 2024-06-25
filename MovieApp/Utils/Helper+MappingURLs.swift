//
//  Helper+MappingURLs.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import Foundation

enum UrlType {
    case trending
    case credit
    case detail
}

enum TrendingType: String {
    case day = "day"
    case week = "week"
}

enum ImageType: String {
    case poster = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/"
    case background = "https://media.themoviedb.org/t/p/w1920_and_h800_multi_faces/"
    case actor = "https://media.themoviedb.org/t/p/w600_and_h900_bestv2/"
}

func mappingURL(urlType: UrlType, trendingType: TrendingType?, movieId: Int?) -> String {
    if urlType == .trending {
        guard let trendingType else { return "" }
        return APIUrls.TMDB_TREND + "\(trendingType.rawValue)?language=ko-KR"
    }
    
    if urlType == .credit {
        guard let movieId else { return "" }
        return APIUrls.TMDB_CREDIT + "\(String(movieId))/credits?language=ko-KR"
    }
    
    if urlType == .detail {
        guard let movieId else { return "" }
        return APIUrls.TMDB_CREDIT + "\(String(movieId))?language=ko-KR"
    }
    
    return ""
}

func mappingMovieImgURL(imageType: ImageType, path: String) -> String {
    return imageType.rawValue + path
}
