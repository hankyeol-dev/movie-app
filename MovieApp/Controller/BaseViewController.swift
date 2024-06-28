//
//  BaseViewController.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
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

extension BaseViewController {
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
    
    func genRightWithSearch() -> UIBarButtonItem {
        let right = UIBarButtonItem(image: UIImage(systemName: Icons.SEARCH.rawValue), style: .plain, target: self, action: #selector(goSearch))
        right.tintColor = ._grayDark
        
        return right
    }
}

extension BaseViewController {
    /**
    @Actions
     */
    
    @objc
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func goSearch() {
        navigationController?.pushViewController(MovieSearchViewController(), animated: true)
    }
}
