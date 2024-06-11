//
//  SearchedItem.swift
//  MovieApp
//
//  Created by 강한결 on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchedItem: UICollectionViewCell {
    
    let thumbnail = UIImageView()
    let movieInfoBox = UIView()
    let movieTitle = UILabel()
    let movieInfo = UILabel()
    let likeButton = UIButton()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configAddSubview()
        configLayout()
        configUI()
    }
    
    
}

extension SearchedItem {
    func configAddSubview() {
        contentView.addSubview(movieInfoBox)
        contentView.addSubview(thumbnail)
        contentView.addSubview(movieTitle)
        contentView.addSubview(movieInfo)
        thumbnail.addSubview(likeButton)
    }
    
    func configLayout() {
        movieInfoBox.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(72)
        }
        thumbnail.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(32)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(200)
        }
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(thumbnail.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(32)
        }
        movieInfo.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(32)
        }
        likeButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(thumbnail).inset(24)
            make.size.equalTo(48)
        }
    }
    
    func configUI() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        movieInfoBox.backgroundColor = .white
        movieInfoBox.layer.cornerRadius = 8
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.layer.cornerRadius = 12
        thumbnail.layer.masksToBounds = true
        movieTitle.font = UIFont._xl_bold
        movieTitle.numberOfLines = 2
        movieTitle.textAlignment = .center
        movieInfo.font = UIFont._md
        movieInfo.textColor = UIColor._gray
        movieInfo.textAlignment = .center
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    func configViewWithData(_ data: Searched) {
        thumbnail.kf.setImage(with: URL(string: mappingMovieImgURL(imageType: .poster, path: data.poster_path ?? "")))
        movieTitle.text = data.title
        movieInfo.text = "\(data.vote_average) 점"
    }
}
