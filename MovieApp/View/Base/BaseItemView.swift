//
//  BaseItemView.swift
//  MovieApp
//
//  Created by 강한결 on 6/27/24.
//

import UIKit

class BaseItemView: BaseView {
    let back = UIView()
    let sectionTitle = BaseLabel("", size: 14, type: .title)
    
    override func configureSubView() {
        self.addSubview(back)
        back.addSubview(sectionTitle)
    }
    
    override func configureLayout() {
        back.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(12)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        sectionTitle.snp.makeConstraints {
            $0.top.equalTo(back.safeAreaLayoutGuide).inset(8)
            $0.horizontalEdges.equalTo(back.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(22)
        }
    }
    
    override func configureUI() {
        back.backgroundColor = .systemGray6
        back.layer.cornerRadius = 8
    }
}
