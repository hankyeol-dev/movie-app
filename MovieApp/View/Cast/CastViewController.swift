//
//  CastViewController.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire

class CastViewController: UIViewController {
    var movieId = 0
    var overview = ""
    var castings: [Cast]?
    
    let movieImage = UIImageView()
    let movieImageCover = UIView()
    let movieTitle = UILabel()
    let moviePoster = UIImageView()
    let movieDetailTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView(isTitled: .isTitled, bgColor: .white, titleText: "출연/제작")
        
        configSubview()
        configLayout()
        configUI()
        configTable()
    }
    
    
    
}

extension CastViewController {
    func configViewWithData(movieId: Int) {
        self.movieId = movieId
        fetchMovieDetail(movieId)
        fetchMovieCasting(movieId)
    }
    
    func fetchMovieDetail(_ movieId: Int) {
        AF.request(mappingURL(urlType: .detail, trendingType: nil, movieId: movieId), headers: HTTPHeaders([API_HEADERS])).responseDecodable(of: MovieDetail.self) { res in
            switch res.result {
            case .success(let v):
                self.movieTitle.text = v.title
                self.movieImage.kf.setImage(with: URL(string: mappingMovieImgURL(imageType: .background, path: v.backdrop_path)))
                self.moviePoster.kf.setImage(with: URL(string: mappingMovieImgURL(imageType: .poster, path: v.poster_path)))
                self.overview = v.overview
                self.movieDetailTable.reloadData()
            case .failure(let e):
                print(e)
            }
        }
    }
    
    func fetchMovieCasting(_ movieId: Int) {
        AF.request(mappingURL(urlType: .credit, trendingType: nil, movieId: movieId), headers: HTTPHeaders([API_HEADERS])).responseDecodable(of: Credit.self) { res in
            switch res.result {
            case .success(let v):
                self.castings = v.cast
                self.movieDetailTable.reloadData()
            case .failure(let e):
                print(e)
            }
        }
    }
}

extension CastViewController {
    // add subview
    func configSubview() {
        self.view.addSubview(movieImage)
        [movieImageCover, movieTitle, moviePoster].forEach {
            movieImage.addSubview($0)
        }
    }
    
    func configLayout() {
        configMovieImageLayout()
    }
    func configMovieImageLayout() {
        movieImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        movieImageCover.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        movieTitle.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(movieImage.safeAreaLayoutGuide).inset(24)
        }
        moviePoster.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(16)
            make.leading.equalTo(movieImage.safeAreaLayoutGuide).inset(24)
            make.bottom.equalTo(movieImage.safeAreaLayoutGuide).inset(24)
            make.trailing.equalTo(movieImage.safeAreaLayoutGuide).inset(220)
        }
    }
    
    func configUI() {
        configMovieImageUI()
    }
    func configMovieImageUI() {
        movieImageCover.backgroundColor = .black.withAlphaComponent(0.5)
        
        movieImage.contentMode = .scaleAspectFill
        movieTitle.font = ._xl_bold
        movieTitle.textColor = .white
        moviePoster.contentMode = .scaleToFill
    }
    
}

extension CastViewController: UITableViewDelegate, UITableViewDataSource {
    func configTable() {
        movieDetailTable.delegate = self
        movieDetailTable.dataSource = self
        movieDetailTable.register(CastingCell.self, forCellReuseIdentifier: CastingCell.id)
        movieDetailTable.register(OverviewCell.self, forCellReuseIdentifier: OverviewCell.id)
        
        view.addSubview(movieDetailTable)
        
        movieDetailTable.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(8)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 100
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "줄거리" : "캐스팅"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let castings else { return 0}
        return section == 0 ? 1 : castings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let castings else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            let overviewCell = movieDetailTable.dequeueReusableCell(withIdentifier: OverviewCell.id, for: indexPath) as! OverviewCell
            overviewCell.configViewWithData(overview)
            return overviewCell
        } else {
            let castingCell = movieDetailTable.dequeueReusableCell(withIdentifier: CastingCell.id, for: indexPath) as! CastingCell
            
            castingCell.configViewWithData(castings[indexPath.row])
            return castingCell
        }
        
    }
    
    
}
