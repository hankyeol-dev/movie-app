//
//  CastingCell.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher

class CastingCell: UITableViewCell {
    var data: Cast?
    
    let actorImage = UIImageView()
    let actorName = UILabel()
    let actorCharacter = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        [actorImage, actorName, actorCharacter].forEach {
            contentView.addSubview($0)
        }
        
        actorImage.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(72)
        }
        
        actorName.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(actorImage.snp.trailing).offset(20)
        }
        
        actorCharacter.snp.makeConstraints { make in
            make.top.equalTo(actorName.snp.bottom).offset(12)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(actorImage.snp.trailing).offset(20)
        }
    }
    
    func configViewWithData(_ cellData: Cast) {
        data = cellData
        guard let data else { return }
        guard let image = data.profile_path else {
            actorImage.backgroundColor = .gray
            return;
        }
        
        actorImage.kf.setImage(with: URL(string: mappingMovieImgURL(imageType: .actor, path: image)))
        actorName.text = data.name
        actorCharacter.text = data.character
    }
}
