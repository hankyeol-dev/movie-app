//
//  MovieDetailCast.swift
//  MovieApp
//
//  Created by 강한결 on 6/27/24.
//

import UIKit
import SnapKit

class MovieDetailCast: BaseItemView {
    private let sectionDirector = BaseLabel("감독", size: 10, type: .normal)
    private let sectionCasting = BaseLabel("출연진", size: 10, type: .normal)
    private let sectionDivider = UIView()
    
    let directorCollection = UICollectionView(frame: .zero, collectionViewLayout: MovieDetailCast.collectionLayout())
    let castingCollection = UICollectionView(frame: .zero, collectionViewLayout: MovieDetailCast.collectionLayout())
    
    
    convenience init(_ t: String) {
        self.init(frame: .zero)
        super.sectionTitle.changeText(t)
    }
    
    override func configureSubView() {
        super.configureSubView()
        
        [sectionDirector, directorCollection , sectionDivider, sectionCasting, castingCollection].forEach {
            super.back.addSubview($0)
        }
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        sectionDirector.snp.makeConstraints {
            $0.top.equalTo(super.sectionTitle.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(super.back.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(16)
        }
        
        directorCollection.snp.makeConstraints {
            $0.top.equalTo(sectionDirector.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(super.back.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(130)
        }
        
        sectionDivider.snp.makeConstraints {
            $0.top.equalTo(directorCollection.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(super.back.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(1)
        }
        
        sectionCasting.snp.makeConstraints {
            $0.top.equalTo(sectionDivider.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(super.back.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(16)
        }
        
        castingCollection.snp.makeConstraints {
            $0.top.equalTo(sectionCasting.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(super.back.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(130)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        sectionDivider.layer.borderWidth = 1
        sectionDivider.layer.borderColor = UIColor._gray.cgColor
        directorCollection.backgroundColor = .none
        directorCollection.showsHorizontalScrollIndicator = false
        castingCollection.backgroundColor = .none
        castingCollection.showsHorizontalScrollIndicator = false
    }
}

extension MovieDetailCast {
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
