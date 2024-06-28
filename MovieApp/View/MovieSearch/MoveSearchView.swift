//
//  File.swift
//  MovieApp
//
//  Created by 강한결 on 6/28/24.
//

import UIKit
import SnapKit

class MovieSearchView: BaseView {
    let header = MovieSearchHeader("영화를 검색해보세요 (ex. 해리포터)")
    let table = UITableView()
    private let errorLabel = BaseLabel("검색 결과를 찾을 수 없습니다.", size: 16, type: .error)
    
    override func configureSubView() {
        [header].forEach {
            self.addSubview($0)
        }
    }
    override func configureLayout() {
        header.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
    }
    
    override func configureUI() {
        table.separatorStyle = .none
    }
    
    func configureErrorView() {
        self.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func configureSuccessView() {
        self.addSubview(table)
        
        table.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
