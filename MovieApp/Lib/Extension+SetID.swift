//
//  Extension+SetID.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import Foundation
import UIKit

protocol SetID {
    static var id: String { get }
}

extension UIViewController: SetID {
    static var id: String {
        return String(describing: self)
    }
}
extension UITableViewCell: SetID {
    static var id: String {
        return String(describing: self)
    }
}
