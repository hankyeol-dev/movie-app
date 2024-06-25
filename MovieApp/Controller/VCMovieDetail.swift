//
//  VCMovieDetail.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import UIKit
import SnapKit


class VCMovieDetail: VCBase {
    private lazy var movie: Movie = Movie(id: 0, backdrop_path: "", poster_path: "", genre_ids: [0], title: "", release_date: "", vote_average: 3.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNav(title: movie.title, leftBarItem: genLeftWithGoBack(), rightBarItem: nil)
    }
}

extension VCMovieDetail {
    /**
     @View
     */
    
    func configureViewWithData(_ data: Movie) {
        self.movie = data
    }
}

extension VCMovieDetail {
    /**
     @Action
     */
}
