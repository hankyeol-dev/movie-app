//
//  VLabel.swift
//  MovieApp
//
//  Created by 강한결 on 6/25/24.
//

import UIKit

class BaseLabel: UILabel {
    
    enum LabelType {
        case normal, title, subTitle, date, error
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ t: String, size: CGFloat, type: LabelType) {
        self.init(frame: .zero)
        
        text = t
        configureFontByType(size: size, type: type)
    }
    
    private func configureFontByType(size: CGFloat, type: LabelType) {
        switch type {
        case .normal, .date:
            font = .systemFont(ofSize: size)
            textColor = .systemGray
        case .title, .subTitle:
            font = .boldSystemFont(ofSize: size)
            textColor = .black
        case .error:
            font = .boldSystemFont(ofSize: size)
            textColor = ._grayDark
            textAlignment = .center
        }
    }
    
    func changeText(_ t: String) {
        text = t
    }
    
    func changeColor(_ c: UIColor) {
        textColor = c
    }
}
