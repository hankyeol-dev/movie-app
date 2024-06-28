//
//  MovieDetailCastingItem.swift
//  MovieApp
//
//  Created by 강한결 on 6/27/24.
//

import UIKit
import SnapKit
import Kingfisher

class MovieDetailCastingItem: BaseCollectionItem {
    private let image = UIImageView()
    private let infoBox = UIStackView()
    private let name = BaseLabel("", size: 12, type: .normal)
    private let job = BaseLabel("", size: 10, type: .normal)
    
    override func configureSubview() {
        [image, infoBox].forEach {
            contentView.addSubview($0)
        }
        [name, job].forEach {
            infoBox.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
        image.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.height.equalTo(contentView.frame.width)
        }
        infoBox.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(8)
            $0.bottom.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        image.layer.cornerRadius = contentView.frame.width / 2
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        
        infoBox.axis = .vertical
        infoBox.spacing = 4
        infoBox.distribution = .equalSpacing
    }
    
    func configureViewWithData(_ data: MovieCrew) {
        image.kf.setImage(with: URL(string: ImageBaseURL.ACTOR.rawValue + (data.profile_path ?? ""))!)
        name.changeText(data.name)
        job.changeText(data.job)
    }
    
    func configureViewWithData(_ data: MovieCast) {
        image.kf.setImage(with: URL(string: ImageBaseURL.ACTOR.rawValue + (data.profile_path ?? ""))!)
        name.changeText(data.name)
        job.changeText(data.character)
    }
    
    func configureViewWithData(_ data: Movie) {
        image.kf.setImage(with: URL(string: ImageBaseURL.POSTER.rawValue + data.poster_path))
        name.changeText(data.title)
        job.changeText("평점: " + data.formattedVoteAvg)
    }
}
