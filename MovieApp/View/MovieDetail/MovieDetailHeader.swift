//
//  DetailHeaderView.swift
//  MovieApp
//
//  Created by 강한결 on 6/26/24.
//

import UIKit
import SnapKit
import Kingfisher

class MovieDetailHeader: BaseView {
    let backDrop = UIImageView()
    let backDropTint = UIView()
    let poster = UIImageView()
    let movieInfoBox = UIStackView()
    let movieTitle = BaseLabel("", size: 22, type: .title)
    let movieGenres = BaseLabel("", size: 15, type: .normal)
    let movieRelease = BaseLabel("", size: 13, type: .normal)
    
    override func configureSubView() {
        self.addSubview(backDrop)
        backDrop.addSubview(backDropTint)
        [poster, movieInfoBox].forEach {
            backDropTint.addSubview($0)
        }
        [movieTitle, movieGenres, movieRelease].forEach {
            movieInfoBox.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
        backDrop.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        backDropTint.snp.makeConstraints {
            $0.edges.equalTo(backDrop.safeAreaLayoutGuide)
        }
        poster.snp.makeConstraints {
            $0.leading.equalTo(backDropTint.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(backDropTint.safeAreaLayoutGuide).inset(32)
            $0.bottom.equalTo(backDropTint.safeAreaLayoutGuide)
            $0.width.equalTo(110)
        }
        movieInfoBox.snp.makeConstraints {
            $0.leading.equalTo(poster.snp.trailing).offset(24)
            $0.trailing.equalTo(backDropTint.safeAreaLayoutGuide).inset(16)
            $0.verticalEdges.equalTo(backDropTint.safeAreaLayoutGuide).inset(32)
        }
    }
    
    override func configureUI() {
        backDrop.contentMode = .scaleToFill
        poster.contentMode = .scaleToFill
        
        backDropTint.backgroundColor = .black.withAlphaComponent(0.5)
        
        movieInfoBox.axis = .vertical
        movieInfoBox.spacing = 4
        movieInfoBox.alignment = .leading
        movieInfoBox.distribution = .equalSpacing
        
        movieTitle.changeColor(.white)
        
        movieGenres.changeColor(.white)
        movieRelease.changeColor(.white)
    }
    
    func configureViewWithData(_ data: MovieDetailHeaderData) {
        backDrop.kf.setImage(with: URL(string: data.backdrop))
        poster.kf.setImage(with: URL(string: data.poster))
        movieTitle.changeText(data.title)
        movieGenres.changeText(data.genres)
        movieRelease.changeText(data.release_date)
    }
}
