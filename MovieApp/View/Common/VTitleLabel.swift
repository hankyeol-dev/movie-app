//
//  VTitleLabel.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import UIKit

class VTitleLabel: VBase {    
    let back = UIView()
    let label = UILabel()
    let button = UIButton()
    
    convenience init(_ t: String) {
        self.init(frame: .zero)
        
        label.text = t
    }
    
    override func configureSubView() {
        self.addSubview(back)
        [label, button].forEach {
            back.addSubview($0)
        }
    }
    
    override func configureLayout() {
        back.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        label.snp.makeConstraints {
            $0.verticalEdges.leading.equalTo(back.safeAreaLayoutGuide)
        }
        button.snp.makeConstraints {
            $0.verticalEdges.equalTo(back.safeAreaLayoutGuide).inset(14)
            $0.leading.equalTo(label.snp.trailing).offset(4)
            $0.size.equalTo(10)
        }
    }
    
    override func configureUI() {
        label.font = ._md_bold
        label.textColor = .black
        button.setImage(UIImage(systemName: Icons.RIGHT_ARROW.rawValue), for: .normal)
        button.tintColor = .darkGray
    }
    
    func changeText(_ t: String) {
        label.text = t
    }
}

