//
//  Extension+UIVC.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import Foundation
import UIKit

enum isWithTitle {
    case isTitled
    case isNotTitled
}

extension UIViewController {
    func configView(isTitled: isWithTitle, bgColor: UIColor, titleText: String?) {
        self.view.backgroundColor = bgColor
        
        if isTitled == .isTitled {
            self.title = titleText ?? ""
        }
    }
}
