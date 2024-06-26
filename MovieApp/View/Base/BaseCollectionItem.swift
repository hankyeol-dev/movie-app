//
//  VCollectionItemBase.swift
//  MovieApp
//
//  Created by 강한결 on 6/25/24.
//

import UIKit
import SnapKit

class BaseCollectionItem: UICollectionViewCell {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubview()
        configureLayout()
        configureUI()
    }
    
    func configureSubview() {}
    func configureLayout() {}
    func configureUI() {}
}
