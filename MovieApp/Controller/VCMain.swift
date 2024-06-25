//
//  VCMain.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire

class VCMain: VCBase {

    private var mainView = VMain()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNav(title: Texts.Title.TITLE_MAIN.rawValue, leftBarItem: nil, rightBarItem: nil)
    }
    
}


extension VCMain{
    
}

extension VCMain {
    
}
