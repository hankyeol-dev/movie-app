//
//  MovieSearchHeader.swift
//  MovieApp
//
//  Created by 강한결 on 6/28/24.
//

import UIKit
import SnapKit

class MovieSearchHeader: BaseItemView {
    private let searchContentView = UIView()
    let searchBar = BaseTextField()
    private let searchIcon = UIImageView(image: UIImage(systemName: Icons.SEARCH.rawValue))
    let searchButton = UIButton()
    
    convenience init(_ t: String) {
        self.init(frame: .zero)
        super.sectionTitle.changeText(t)
    }
    
    override func configureSubView() {
        super.configureSubView()
        super.back.addSubview(searchContentView)
        [searchBar].forEach {
            searchContentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        let guide = searchContentView.safeAreaLayoutGuide
        
        searchContentView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(super.back.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(super.sectionTitle.snp.bottom).offset(8)
            $0.bottom.equalTo(super.back.safeAreaLayoutGuide).inset(12)
        }
        
        searchBar.snp.makeConstraints {
            $0.edges.equalTo(guide)
        }
        
    }
    
    override func configureUI() {
        super.configureUI()
        
        searchButton.configuration = .searchButton(t: "검색", type: .notSearching)
        searchButton.isEnabled = false
        
        searchBar.leftView = searchIcon
        searchBar.leftViewMode = .always
        
        searchBar.rightView = searchButton
        searchBar.rightViewMode = .always
        
        searchBar.layer.cornerRadius = 8
        searchBar.backgroundColor = .systemGray5
        searchBar.tintColor = ._grayDark
        searchBar.font = .systemFont(ofSize: 14)
        
    }
   
    func changeSearchButtonConfig(_ type: SearchButtonType) {
        self.searchButton.isEnabled = type == .searching ? true : false
        self.searchButton.configuration = .searchButton(t: "검색", type: type)
    }
    
    func moveOutTextOnTextfield() {
        self.searchBar.text = ""
        self.changeSearchButtonConfig(.notSearching)
    }
}
