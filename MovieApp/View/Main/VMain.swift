//
//  VMain.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import UIKit

class VMain: VBase {
    let table = UITableView()
    
    override func configureSubView() {
        self.addSubview(table)
    }
    
    override func configureLayout() {
        table.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
