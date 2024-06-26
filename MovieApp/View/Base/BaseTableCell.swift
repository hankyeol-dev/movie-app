//
//  VTableCellBase.swift
//  MovieApp
//
//  Created by 강한결 on 6/25/24.
//

import UIKit
import SnapKit

class BaseTableCell: UITableViewCell {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubview()
        configureLayout()
        configureUI()
    }
    
    func configureSubview() {}
    func configureLayout() {}
    func configureUI() {}
}
