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
        case CURRENT_RUNNING = "현재 상영작"
    }
    enum Buttons: String {
        case TABBAR_HOME = "홈"
        case TABBAR_USER = "마이페이지"
    }
}
