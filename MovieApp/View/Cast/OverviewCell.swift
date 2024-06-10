//
//  OverviewCell.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import UIKit
import SnapKit

class OverviewCell: UITableViewCell {
    var isToggled = false
    
    let coverView = UIView()
    let overviewText = UILabel()
    let overviewButton = UIButton()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configView()
    }
    
    func configView() {
        contentView.addSubview(coverView)
        contentView.addSubview(overviewText)
        contentView.addSubview(overviewButton)
        
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        overviewText.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
        overviewButton.snp.makeConstraints { make in
            make.top.equalTo(overviewText.snp.bottom).offset(16)
            make.bottom.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
        overviewButton.setImage(self.isToggled ? UIImage(systemName: "arrow.up") : UIImage(systemName: "arrow.down"), for: .normal)
        overviewButton.addTarget(self, action: #selector(toggleOverviewBtn), for: .touchUpInside)
    }
    
    @objc func toggleOverviewBtn(_ sender: UIButton) {
        isToggled.toggle()
        overviewText.numberOfLines = isToggled ? 0 : 2
        overviewButton.setImage(self.isToggled ? UIImage(systemName: "arrow.up") : UIImage(systemName: "arrow.down"), for: .normal)
    }
    
    func configViewWithData(_ overview: String) {
        overviewText.text = overview
    }
}
