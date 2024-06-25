//
//  VMain.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import UIKit

class VMain: VBase {
    let back = UIView()
    let titleLabel = VTitleLabel(Texts.Title.CURRENT_RUNNING.rawValue, type: .large)
    
    required init?(coder: NSCoder) {
        fatalError("error VTitleLabel")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureSubView() {
        self.addSubview(back)
        
        [titleLabel].forEach {
            back.addSubview($0)
        }
    }
    
    override func configureLayout() {
        back.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(back.safeAreaLayoutGuide).inset(8)
            $0.horizontalEdges.equalTo(back.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(40)
        }
    }
}
