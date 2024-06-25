//
//  VMainTableCell.swift
//  MovieApp
//
//  Created by 강한결 on 6/25/24.
//

import UIKit

class NormalTableViewCell: VTableCellBase {
    let label = VTitleLabel("")
    let collection = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 120, height: 200)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func configureSubview() {
        [label, collection].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        let guide = contentView.safeAreaLayoutGuide
        label.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(guide).inset(16)
            $0.height.equalTo(24)
        }
        collection.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(16)
            $0.leading.equalTo(guide)
            $0.bottom.trailing.equalTo(guide).inset(8)
        }
    }
    
}
