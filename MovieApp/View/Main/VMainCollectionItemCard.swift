//
//  VMainCollectionItemCard.swift
//  MovieApp
//
//  Created by 강한결 on 6/25/24.
//

import UIKit

class VMainCollectionItemCard: VCollectionItemBase {
    private let image = UIImageView()
    private let infoBox = UIView()
    private let infoTitle = VLabel("", type: .normal)
    private let infoRate = VLabel("", type: .normal)
    private let infoDate = VLabel("", type: .sub)
    
override func configureSubview() {
        [image, infoBox].forEach {
            contentView.addSubview($0)
        }
        [infoTitle, infoRate, infoDate].forEach {
            infoBox.addSubview($0)
        }
    }
    
    override func configureLayout() {
        let guide = contentView.safeAreaLayoutGuide
        
        image.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(guide)
            $0.height.equalTo(100)
        }
        
        infoBox.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(guide)
            $0.height.equalTo(80)
        }
        
        infoTitle.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.top.horizontalEdges.equalTo(infoBox.safeAreaLayoutGuide).inset(8)
        }
        
        infoRate.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.top.equalTo(infoTitle.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(infoBox.safeAreaLayoutGuide).inset(8)
        }
        
        infoDate.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.top.equalTo(infoRate.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(infoBox.safeAreaLayoutGuide).inset(8)
        }
    }
    
    override func configureUI() {
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        infoBox.backgroundColor = .systemGray6
        infoDate.changeColor(.systemGray)
        infoDate.textAlignment = .right
    }
    
    func configureViewWithData(_ data: Movie) {
        image.kf.setImage(with: URL(string: URLs.Img.BACKGROUND.rawValue + data.backdrop_path))
        infoTitle.changeText(data.title)
        infoRate.changeText("평점: " + data.formattedVoteAvg)
        infoDate.changeText(data.release_date)
    }
}
