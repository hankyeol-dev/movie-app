//
//  SearchedItemTableCell.swift
//  MovieApp
//
//  Created by 강한결 on 6/11/24.
//

import UIKit
import SnapKit

class SearchedItemTableCell: UITableViewCell {
    
    let titleLabel = UILabel()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        titleLabel.font = UIFont._lg_bold
        titleLabel.textColor = .black
    }
    
    func configTitleLabelByData(_ text: String) {
        titleLabel.text = text
    }
}
