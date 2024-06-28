//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by 강한결 on 6/26/24.
//

import UIKit
import SnapKit

class MovieDetailView: BaseView {
    let scroll = UIScrollView()
    let scrollContentView = UIView()
    let header = MovieDetailHeader()
    let rating = MovieDetailRating("평점 남기기")
    let overview = MovieDetailOverview("줄거리")
    let casting = MovieDetailCast("감독 | 출연진")
    let recommend = MovieDetailRecommendation("추천 작품")
    
    override func configureSubView() {
        self.addSubview(scroll)
        scroll.addSubview(scrollContentView)
        [header, rating, overview, casting, recommend].forEach {
            scrollContentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        scroll.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        scrollContentView.snp.makeConstraints {
            $0.edges.equalTo(scroll.contentLayoutGuide)
            $0.width.equalTo(scroll.frameLayoutGuide)
            $0.height.equalTo(1000)
        }
        header.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(scrollContentView.safeAreaLayoutGuide)
            $0.height.equalTo(150)
        }
        rating.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.horizontalEdges.equalTo(scrollContentView.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        overview.snp.makeConstraints {
            $0.top.equalTo(rating.snp.bottom)
            $0.horizontalEdges.equalTo(scrollContentView.safeAreaLayoutGuide)
            $0.height.equalTo(150)
        }
        casting.snp.makeConstraints {
            $0.top.equalTo(overview.snp.bottom)
            $0.horizontalEdges.equalTo(scrollContentView.safeAreaLayoutGuide)
            $0.height.equalTo(400)
        }
        recommend.snp.makeConstraints {
            $0.top.equalTo(casting.snp.bottom)
            $0.horizontalEdges.equalTo(scrollContentView.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
    }
    
    func configureViewWithData(_ data: MovieDetail, userRating: Int = 0) {
        header.configureViewWithData(data.forMovieDetailHeaders)
        rating.configureViewWithData(userRating)
        overview.configureViewWithData(data.overview)
    }
}
