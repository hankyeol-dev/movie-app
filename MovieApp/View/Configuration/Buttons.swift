//
//  Buttons.swift
//  MovieApp
//
//  Created by 강한결 on 6/27/24.
//

import UIKit

extension UIButton.Configuration {
    static func starRatedButton(_ img: UIImage, _ c: UIColor = .systemYellow) -> UIButton.Configuration {
        var config = UIButton.Configuration.borderless()
        
        config.baseForegroundColor = c
        config.image = img
        config.image?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        return config
    }
}
