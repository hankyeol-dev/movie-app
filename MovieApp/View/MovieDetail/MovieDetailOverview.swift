//
//  MovieDetailOverview.swift
//  MovieApp
//
//  Created by 강한결 on 6/27/24.
//

import UIKit
import SnapKit

class MovieDetailOverview: BaseItemView {
    private let overview = BaseLabel("", size: 12, type: .normal)
    
    convenience init(_ t: String) {
        self.init(frame: .zero)
        super.sectionTitle.changeText(t)
    }
    
    override func configureSubView() {
        super.configureSubView()
        super.back.addSubview(overview)
    }
    
    override func configureLayout() {
        super.configureLayout()
        overview.snp.makeConstraints {
            $0.top.equalTo(super.sectionTitle.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(back.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(back.safeAreaLayoutGuide).inset(12)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        overview.numberOfLines = 4
    }
    
    func configureViewWithData(_ data: String) {
        overview.text = data
    }
}
