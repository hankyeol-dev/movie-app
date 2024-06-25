//
//  Constants.swift
//  MovieApp
//
//  Created by 강한결 on 6/11/24.
//

import Foundation

enum Icons: String {
    case SEARCH = "magnifyingglass"
    case LEFT_ARROW = "chevron.left"
    case RIGHT_ARROW = "chevron.right"
    case TAB_HOUSE = "house.circle.fill"
    case TAB_USER = "person.circle.fill"
}

enum Texts {
    enum Title: String {
        case TITLE_MAIN = "영화"
        case TITLE_MOVIE_DETAIL = "상세"
    }
    
    enum Buttons: String {
        case TABBAR_HOME = "홈"
        case TABBAR_USER = "마이페이지"
    }
}

enum URLs {
    enum Img: String {
        case POSTER = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/"
        case BACKGROUND = "https://media.themoviedb.org/t/p/w1920_and_h800_multi_faces/"
        case ACTOR = "https://media.themoviedb.org/t/p/w600_and_h900_bestv2/"
    }
}
