//
//  VMainTableCell.swift
//  MovieApp
//
//  Created by 강한결 on 6/25/24.
//

import UIKit
import SnapKit

class NormalTableCell: BaseTableCell {
    private let title = BaseLabelWithButton("")
    let collection = UICollectionView(frame: .zero, collectionViewLayout: NormalTableCell.layout())
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 110, height: 160)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    override func configureSubview() {
        contentView.addSubview(title)
        contentView.addSubview(collection)
    }
    
    override func configureLayout() {
        title.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(24)
        }
        collection.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }

    
    func changeTitle(_ t: String) {
        self.title.changeText(t)
    }
    
}
