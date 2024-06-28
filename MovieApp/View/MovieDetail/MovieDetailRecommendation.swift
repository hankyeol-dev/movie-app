//
//  MovieDetailRecommendation.swift
//  MovieApp
//
//  Created by 강한결 on 6/28/24.
//

import UIKit
import SnapKit

class MovieDetailRecommendation: BaseItemView {
    
    let collection = UICollectionView(frame: .zero, collectionViewLayout: MovieDetailRecommendation.collectionLayout())
    
    
    convenience init(_ t: String) {
        self.init(frame: .zero)
        super.sectionTitle.changeText(t)
    }
    
    override func configureSubView() {
        super.configureSubView()
        self.addSubview(collection)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        collection.snp.makeConstraints {
            $0.top.equalTo(super.sectionTitle.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(super.back.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(super.back.safeAreaLayoutGuide).inset(12)
        }
        
    }
    
    override func configureUI() {
        super.configureUI()
        
        collection.backgroundColor = .none
        collection.showsHorizontalScrollIndicator = false
    }
}

extension MovieDetailRecommendation {
    static func collectionLayout() -> UICollectionViewFlowLayout {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize(width: 80, height: 120)
        l.minimumLineSpacing = 8
        l.minimumInteritemSpacing = 0
        l.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        l.scrollDirection = .horizontal
        return l
    }
}
