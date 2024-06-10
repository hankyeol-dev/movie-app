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
}

enum TrendingType: String {
    case day = "day"
    case week = "week"
}

enum ImageType: String {
    case poster = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/"
    case background = "https://media.themoviedb.org/t/p/w1920_and_h800_multi_faces/"
}

func mappingURL(urlType: UrlType, trendingType: TrendingType?, movieId: Int?) -> String {
    if urlType == .trending {
        guard let trendingType else { return "" }
        return APIUrls.TMDB_TREND + "\(trendingType.rawValue)?language=ko-KR"
    }
    
    if urlType == .credit {
        guard let movieId else { return "" }
        return APIUrls.TMDB_CREDIT + "\(movieId)/credits?language=ko-KR"
    }
    
    return ""
}

func mappingMovieImgURL(imageType: ImageType, path: String) -> String {
    return imageType == ImageType.poster ?
    ImageType.poster.rawValue + path
    : ImageType.background.rawValue + path
}
