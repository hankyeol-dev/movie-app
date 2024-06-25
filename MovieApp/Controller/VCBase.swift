//
//  VCBase.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import UIKit
import SnapKit

class VCBase: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        configureSubView()
        configureLayout()
        configureUI()
        configureAction()
    }
    func configureSubView() {}
    func configureLayout() {}
    func configureUI() {}
    func configureAction() {}
}

extension VCBase {
    /**
     @navigation
     */
    func configureNav(title: String, leftBarItem: UIBarButtonItem?, rightBarItem: UIBarButtonItem?) {
        
        self.title = title
        
        if let left = leftBarItem {
            navigationItem.leftBarButtonItem = left
        }
        
        if let right = rightBarItem {
            navigationItem.rightBarButtonItem = right
        }
        
    }

    func genLeftWithGoBack() -> UIBarButtonItem {
        let left = UIBarButtonItem(image: UIImage(systemName: Icons.LEFT_ARROW.rawValue), style: .plain, target: self, action: #selector(goBack))
        left.tintColor = ._grayDark
        
        return left
    }
}

extension VCBase {
    /**
    @Actions
     */
    
    @objc
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
