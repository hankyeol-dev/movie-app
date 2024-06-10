//
//  TrendViewCell.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class TrendViewCell: UITableViewCell {
    
    var data: Movie?
    var genre: [Genre]?
    var credit: [Cast]?
    
    let backView = UIView()
    
    let dateLabel = UILabel()
    let genresLabel = UILabel()
    let cardView = UIView()
    
    let movieImage = UIImageView()
    let clipButton = UIButton()
    let rateStackView = UIStackView()
    let rateTitle = UILabel()
    let ratePoint = UILabel()
    
    let movieInfoBox = UIView()
    let movieTitle = UILabel()
    let movieCredits = UILabel()
    let divider = UIView()
    let cardNavView = UIView()
    let seeDetailLabel = UILabel()
    let goDetailButton = UIButton()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configLayout()
        configUI()
    }
}

extension TrendViewCell {
    func configViewWithData(_ cellData: Movie, _ cellGenres: [Genre]) {
        data = cellData
        genre = cellGenres
        guard let data, let genre else { return }
        
        // view 객체에 데이터 부여하기
        dateLabel.text = data.release_date
        genresLabel.text = mappingGenre(genresDB: genre, targetGenres: data.genre_ids)
        movieImage.kf.setImage(with: URL(string: mappingMovieImgURL(imageType: .background, path: data.backdrop_path)))
        movieTitle.text = data.title
        movieCredits.text = data.title
        ratePoint.text = data.formattedVoteAvg
        fetchCredit(data.id)
    }
    
    func fetchCredit(_ movieId: Int) {
        AF.request(mappingURL(urlType: .credit, trendingType: nil, movieId: movieId), headers: HTTPHeaders([API_HEADERS])).responseDecodable(of: Credit.self) { res in
            switch res.result {
            case .success(let v):
                self.movieCredits.text = v.formattedCastName
            case .failure(let e):
                print(e)
            }
        }
    }
}

extension TrendViewCell {
    // ui
    func addSubviews() {
        self.contentView.addSubview(backView)
        [dateLabel, genresLabel, cardView].forEach {
            backView.addSubview($0)
        }
        [movieImage, movieInfoBox].forEach {
            cardView.addSubview($0)
        }
        [rateStackView, clipButton].forEach {
            movieImage.addSubview($0)
        }
        [rateTitle, ratePoint].forEach {
            rateStackView.addArrangedSubview($0)
        }
        [movieTitle, movieCredits, divider, cardNavView].forEach {
            movieInfoBox.addSubview($0)
        }
        [seeDetailLabel, goDetailButton].forEach {
            cardNavView.addSubview($0)
        }
    }
    
    func configLayout() {
        configMainLayout()
        configCardViewLayout()
        configMovieImageLayout()
        configMovieInfoLayout()
        configSeeDetailLayout()
    }
    
    func configUI() {
        configMainUI()
        configCardViewUI()
        configMovieImageUI()
        configMovieInfoUI()
        configSeeDetailUI()
        configMovieRateUI()
    }
    
    func configMainLayout(){
        dateLabel.snp.makeConstraints { l in
            backView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(16)
            }
            
            dateLabel.snp.makeConstraints { make in
                make.horizontalEdges.top.equalTo(backView.safeAreaLayoutGuide)
            }
            
            genresLabel.snp.makeConstraints { make in
                make.top.equalTo(dateLabel.snp.bottom).offset(8)
                make.horizontalEdges.equalTo(backView.safeAreaLayoutGuide)
            }
            
            cardView.snp.makeConstraints { make in
                make.top.equalTo(genresLabel.snp.bottom).offset(12)
                make.horizontalEdges.bottom.equalTo(backView.safeAreaLayoutGuide)
            }
        }
    }
    func configCardViewLayout() {
        movieImage.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(300)
        }
        movieInfoBox.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(120)
        }
    }
    func configMovieImageLayout() {
        rateStackView.snp.makeConstraints { make in
            make.leading.equalTo(movieImage.safeAreaLayoutGuide).inset(24)
            make.bottom.equalTo(movieImage.safeAreaLayoutGuide).inset(80)
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
        clipButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(movieImage.safeAreaLayoutGuide).inset(24)
            make.size.equalTo(24)
        }
    }
    func configMovieInfoLayout() {
        movieTitle.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16)
        }
        movieCredits.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(movieTitle.snp.bottom).offset(8)
        }
        divider.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(movieCredits.snp.bottom).offset(12)
            make.height.equalTo(1)
        }
        cardNavView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(12)
            make.bottom.equalTo(movieInfoBox.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    func configSeeDetailLayout() {
        seeDetailLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
        }
        goDetailButton.snp.makeConstraints { make in
            make.trailing.verticalEdges.equalToSuperview()
        }
    }
    
    func configMainUI() {
        dateLabel.font = ._sm
        dateLabel.textColor = ._gray
        dateLabel.textAlignment = .left
        
        genresLabel.font = ._lg_bold
        genresLabel.textAlignment = .left
        
        cardView.layer.cornerRadius = 12
        cardView.clipsToBounds = true
    }
    func configCardViewUI() {
        movieImage.contentMode = .scaleAspectFill
        movieInfoBox.backgroundColor = .white
    }
    func configMovieImageUI() {
        rateStackView.axis = .horizontal
        rateStackView.spacing = 0
        rateStackView.distribution = .fillEqually
        
        clipButton.setImage(UIImage(systemName: "paperclip"), for: .normal)
        clipButton.backgroundColor = .white
        clipButton.layer.cornerRadius = clipButton.frame.size.width / 2
        clipButton.clipsToBounds = true
    }
    func configMovieRateUI() {
        rateTitle.text = "평점"
        rateTitle.font = UIFont._md
        rateTitle.backgroundColor = .purple
        rateTitle.textColor = .white
        rateTitle.textAlignment = .center
        
        ratePoint.font = UIFont._md
        ratePoint.backgroundColor = .white
        ratePoint.textColor = .black
        ratePoint.textAlignment = .center
    }
    func configMovieInfoUI() {
        movieTitle.font = UIFont._lg
        movieCredits.font = UIFont._sm
        movieCredits.textColor = .systemGray
        divider.layer.borderColor = UIColor._gray.cgColor
        divider.layer.borderWidth = 1
        
        cardNavView.backgroundColor = .white
    }
    func configSeeDetailUI() {
        seeDetailLabel.text = "자세히 보기"
        seeDetailLabel.font = UIFont._md
        goDetailButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        goDetailButton.tintColor = UIColor._gray
    }
}

