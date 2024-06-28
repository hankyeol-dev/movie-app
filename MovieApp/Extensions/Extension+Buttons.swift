//
//  Buttons.swift
//  MovieApp
//
//  Created by 강한결 on 6/27/24.
//

import UIKit

enum SearchButtonType {
    case searching, notSearching
}

extension UIButton.Configuration {
    static func starRatedButton(_ img: UIImage, _ c: UIColor = .systemYellow) -> UIButton.Configuration {
        var config = UIButton.Configuration.borderless()
        
        config.baseForegroundColor = c
        config.image = img
        config.image?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        return config
    }
    
    static func searchButton(t: String, type: SearchButtonType) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        
        config.title = t
        config.titleAlignment = .center
        config.buttonSize = .mini
        
        switch type {
        case .searching:
            config.baseForegroundColor = .white
            config.baseBackgroundColor = .systemBlue
        case .notSearching:
            config.baseForegroundColor = ._grayDark
            config.baseBackgroundColor = .systemGray3
        }
        
        return config
    }
}
