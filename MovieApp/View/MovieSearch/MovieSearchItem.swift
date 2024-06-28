//
//  MovieSearchItem.swift
//  MovieApp
//
//  Created by 강한결 on 6/28/24.
//

import UIKit
import SnapKit
import Kingfisher

class MovieSearchItem: BaseTableCell {
    private let back = UIView()
    private let image = UIImageView()
    private let stack = UIStackView()
    private let titleLable = BaseLabel("", size: 14, type: .title)
    private let rateLabel = BaseLabel("", size: 12, type: .normal)
    
    override func configureSubview() {
        contentView.addSubview(back)
        [image, stack].forEach {
            back.addSubview($0)
        }
        [titleLable, rateLabel].forEach {
            stack.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
        back.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        [image, stack].forEach {
            $0.snp.makeConstraints {
                $0.verticalEdges.equalTo(back.safeAreaLayoutGuide).inset(8)
            }
        }
        image.snp.makeConstraints {
            $0.leading.equalTo(back.safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(40)
        }
        stack.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(12)
            $0.trailing.equalTo(back.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func configureUI() {
        back.backgroundColor = .systemGray6
        back.layer.cornerRadius = 8
        
        image.layer.cornerRadius = 4
        image.layer.masksToBounds = true
        image.contentMode = .scaleToFill
        
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillEqually
    }
    
    func configureViewWithData(_ data: Movie) {
        image.kf.setImage(with: URL(string: ImageBaseURL.POSTER.rawValue + data.poster_path))
        titleLable.changeText(data.title)
        rateLabel.changeText("⭐️ 평점: " + data.formattedVoteAvg)
    }
}
