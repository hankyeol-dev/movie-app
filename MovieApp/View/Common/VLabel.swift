//
//  VLabel.swift
//  MovieApp
//
//  Created by 강한결 on 6/25/24.
//

import UIKit

class VLabel: UILabel {
    enum LabelType {
        case title, normal, sub
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ t: String, type: LabelType) {
        self.init(frame: .zero)
        
        text = t
        textColor = .black
        configureFontByType(type)
    }
    
    private func configureFontByType(_ type: LabelType) {
        switch type {
        case .title:
            font = ._lg_bold
        case .normal:
            font = ._md
        case .sub:
            font = ._xs
        }
    }
    
    func changeText(_ t: String) {
        text = t
    }
    
    func changeColor(_ c: UIColor) {
        textColor = c
    }
}
