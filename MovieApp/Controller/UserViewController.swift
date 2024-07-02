//
//  VCUser.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import UIKit

class UserViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNav(title: Texts.Title.TITLE_MYPAGE.rawValue, leftBarItem: nil, rightBarItem: nil)
    }
}
