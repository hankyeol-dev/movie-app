//
//  VMainCollectionItem.swift
//  MovieApp
//
//  Created by 강한결 on 6/25/24.
//

import UIKit
import SnapKit
import Kingfisher

class NormalCollectionItem: BaseCollectionItem {
    private let poster = UIImageView()
    private let title = BaseLabel("", size: 13, type: .subTitle)
    private let rate = BaseLabel("", size: 10, type: .date)
    
    override func configureSubview() {
        [poster, title, rate].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        poster.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.height.equalTo(124)
        }
        title.snp.makeConstraints {
            $0.top.equalTo(poster.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        rate.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        poster.contentMode = .scaleToFill
    }

    func configureViewWithData(_ data: Movie) {
        poster.kf.setImage(with: URL(string: ImageBaseURL.POSTER.rawValue + data.poster_path)!)
        title.changeText(data.title)
        rate.changeText("평점: " + data.formattedVoteAvg)
    }
}
