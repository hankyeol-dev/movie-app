//
//  VMainCollectionItem.swift
//  MovieApp
//
//  Created by 강한결 on 6/25/24.
//

import UIKit

class VMainCollectionItemNormal: VCollectionItemBase {
    let image = UIImageView()
    let titleLabel = VLabel(" ", type: .normal)
    let rateLabel = VLabel(" ", type: .sub)
    
    override func configureSubview() {
        [image, titleLabel, rateLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        let guide = contentView.safeAreaLayoutGuide
                
        image.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(guide)
            $0.height.equalTo(160)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(guide)
        }
        
        rateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(guide)
        }
    }
 
    
    func configureViewWithData(_ data: Movie) {
        image.kf.setImage(with: URL(string: URLs.Img.POSTER.rawValue + data.poster_path))
        titleLabel.changeText(data.title)
        rateLabel.changeText("평점: " + data.formattedVoteAvg)
    }
}
