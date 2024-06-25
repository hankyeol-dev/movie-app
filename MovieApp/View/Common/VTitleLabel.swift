//
//  VTitleLabel.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import UIKit

class VTitleLabel: VBase {
    enum TitleType {
        case small, large
    }
    
    lazy var type: TitleType = .small
    
    let back = UIView()
    let label = UILabel()
    let button = UIButton()
    
    required init?(coder: NSCoder) {
        fatalError("error VTitleLabel")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(_ t: String, type: TitleType) {
        self.init(frame: .zero)
        
        label.text = t
        
        self.type = type
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
            $0.verticalEdges.leading.equalTo(back.safeAreaLayoutGuide).inset(4)
        }
        button.snp.makeConstraints {
            $0.verticalEdges.equalTo(back.safeAreaLayoutGuide).inset(14)
            $0.leading.equalTo(label.snp.trailing).offset(16)
            $0.size.equalTo(12)
        }
    }
    
    override func configureUI() {
        label.font = self.type == .small ? ._md_bold : ._xl_bold
        label.textColor = .black
        button.setImage(UIImage(systemName: Icons.RIGHT_ARROW.rawValue), for: .normal)
        button.tintColor = .black
    }
}

