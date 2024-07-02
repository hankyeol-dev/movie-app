//
//  TestView.swift
//  MovieApp
//
//  Created by 강한결 on 7/1/24.
//

import UIKit
import SnapKit


final class TestView: BaseView {
    private let item = BaseItemView()
    let field = UITextField()
    let button = UIButton()
    let table = UITableView()
    
    override func configureSubView() {
        super.configureSubView()
        
        [item, table].forEach {
            self.addSubview($0)
        }
        
        [field, button].forEach {
            item.addSubview($0)
        }
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        let guide = self.safeAreaLayoutGuide
        
        item.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(guide)
            $0.height.equalTo(160)
        }
        
        table.snp.makeConstraints {
            $0.top.equalTo(item.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(guide).inset(20)
            $0.bottom.equalTo(guide)
        }
        
        field.snp.makeConstraints {
            $0.top.equalTo(item.sectionTitle.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(item.back.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(field.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(item.back.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        item.sectionTitle.changeText("영화 이미지 조회하기")
        
        field.tintColor = .clear
        field.borderStyle = .roundedRect
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor._gray.cgColor
        field.placeholder = "터치해서 영화를 골라보세요!"
        field.textAlignment = .center
        
        button.configuration = .filled()
        button.configuration?.title = "이미지 불러오기"
        button.configuration?.baseBackgroundColor = ._gray
        button.configuration?.baseForegroundColor = ._grayDark
        button.isEnabled = false
    }
    
    func onChangeButtonEnable() {
        button.isEnabled = true
        button.configuration?.baseBackgroundColor = .systemGreen
        button.configuration?.baseForegroundColor = .white
    }
    
    func onChangeButtonDisable() {
        button.isEnabled = false
        button.configuration?.baseBackgroundColor = ._gray
        button.configuration?.baseForegroundColor = ._grayDark
    }
}
