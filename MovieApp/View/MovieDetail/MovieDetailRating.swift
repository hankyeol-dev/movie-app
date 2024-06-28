//
//  MovieDetailRating.swift
//  MovieApp
//
//  Created by 강한결 on 6/26/24.
//

import UIKit
import SnapKit

class MovieDetailRating: BaseItemView {
    private var movieId = -1
    private let totalRate = 5
    private var userRate = 0
    
    private let ratingStack = UIStackView()
    private var rateStars: [UIButton] = []
    private let ratedStar = UIImage(systemName: "star.fill")!
    private let notRatedStar = UIImage(systemName: "star")!

    convenience init(_ t: String) {
        self.init(frame: .zero)
        super.sectionTitle.changeText(t)
        mappingCurrentRate()
    }
    
    override func configureSubView() {
        super.configureSubView()
        super.back.addSubview(ratingStack)
    }
    
    override func configureLayout() {
        super.configureLayout()
        ratingStack.snp.makeConstraints {
            $0.top.equalTo(sectionTitle.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(back.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(back.safeAreaLayoutGuide).inset(8)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        ratingStack.axis = .horizontal
        ratingStack.spacing = 4
        ratingStack.distribution = .fillEqually
        
    }
}

extension MovieDetailRating {
    private func mappingCurrentRate() {
        for rate in 0..<totalRate {
            let star = UIButton()
            star.configuration = .starRatedButton(notRatedStar)
            star.tag = rate
            star.addTarget(self, action: #selector(rating), for: .touchUpInside)
            
            rateStars += [star]
            ratingStack.addArrangedSubview(star)
        }
    }
    
    @objc
    func rating(_ sender: UIButton) {
        if userRate == sender.tag + 1 {
            // 한 번 더 더치한 경우
            for rate in 0..<totalRate {
                rateStars[rate].configuration = .starRatedButton(notRatedStar)
            }
            userRate = 0
        } else {
            for rate in 0...sender.tag {
                rateStars[rate].configuration = .starRatedButton(ratedStar)
            }
            
            for rate in sender.tag + 1..<totalRate {
                rateStars[rate].configuration = .starRatedButton(notRatedStar)
            }
            userRate = sender.tag + 1
        }
        
        UserDefaultService.manager.saveRatedMovies(movieId: self.movieId, rating: self.userRate)
    }
    
    func configureViewWithData(_ rating: Int) {
        for rate in 0..<rating {
            rateStars[rate].configuration = .starRatedButton(ratedStar)
        }
    }
    
    func configurUserRate(movieId: Int, rating: Int) {
        self.movieId = movieId
        self.userRate = rating
    }
}
