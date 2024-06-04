//
//  ViewController.swift
//  MovieApp
//
//  Created by 강한결 on 6/4/24.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    let posterURL = "https://i.namu.wiki/i/DBJQqkz6M8W-g_d9SYq6kA5U8LWupLloptGWYrJg2WjNpQ0-IHmjs3Nvqf7mRriWqpgkUJAFgNSbio-IQWnT4A.webp"
    let movieInfoString = ["test", "•", "test", "•", "test", "•", "test"]
    let movieButtonString = ["+ 찜하기", "바로 보러가기"]
    
    let mainPosterImageView = UIImageView()
    let mainPosterView = UIView()
    
    let movieInfoStackView = UIStackView()
    let movieButtonStackView = UIStackView()
    
    let sectionLabel = UILabel()
    let recommandMovieStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        configureViewInstance()
        configureLayout()
        configureUI()
        
        navigationItem.setRightBarButton(UIBarButtonItem(title: "go", style: .plain, target: self, action: #selector(go)), animated: false)
    }

    
    func configureViewInstance() {
        // add subviews
        
        view.addSubview(mainPosterImageView)
        view.addSubview(sectionLabel)
        view.addSubview(recommandMovieStackView)
        
        mainPosterImageView.addSubview(mainPosterView)
        
        mainPosterView.addSubview(movieInfoStackView)
        mainPosterView.addSubview(movieButtonStackView)
        
        generateMovieInfoLabels().forEach {
            movieInfoStackView.addArrangedSubview($0)
        }
        
        generateMovieButtons().forEach {
            movieButtonStackView.addArrangedSubview($0)
        }
        
        [UIColor.black, UIColor.green, UIColor.yellow].map {
            let view = UIImageView()
            view.backgroundColor = $0
//            view.contentMode = .scaleAspectFill
            view.layer.cornerRadius = 4
            return view
        }.forEach {
            recommandMovieStackView.addArrangedSubview($0)
        }
    }

    func configureLayout() {
        mainPosterImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(400)
        }
        
        mainPosterView.snp.makeConstraints { make in
            make.edges.equalTo(mainPosterImageView)
        }
        
        movieInfoStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80)
            make.horizontalEdges.equalToSuperview().inset(40)
        }
        
        movieButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(movieInfoStackView).offset(32)
            make.horizontalEdges.equalToSuperview().inset(40)
        }
        
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainPosterImageView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        recommandMovieStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.top.equalTo(sectionLabel.snp.bottom).offset(20)
            make.height.equalTo(80)
        }
    }
    
    func configureUI() {
        mainPosterView.backgroundColor = .black.withAlphaComponent(0.5)
        
        mainPosterImageView.kf.setImage(with: URL(string: posterURL))
        mainPosterImageView.contentMode = .scaleAspectFill
        mainPosterImageView.layer.cornerRadius = 20
        mainPosterImageView.layer.masksToBounds = true
        
        movieInfoStackView.backgroundColor = .clear
        movieInfoStackView.axis = .horizontal
        movieInfoStackView.spacing = 8
        movieInfoStackView.alignment = .center
        movieInfoStackView.distribution = .equalSpacing
        
        movieButtonStackView.backgroundColor = .clear
        movieButtonStackView.axis = .horizontal
        movieButtonStackView.spacing = 8
        movieButtonStackView.alignment = .center
        movieButtonStackView.distribution = .fillEqually
        
        sectionLabel.text = "asf"
        sectionLabel.font = .systemFont(ofSize: 15)
        sectionLabel.textColor = .black
        
        recommandMovieStackView.axis = .horizontal
        recommandMovieStackView.spacing = 8
        recommandMovieStackView.alignment = .center
        recommandMovieStackView.distribution = .fillEqually
        recommandMovieStackView.backgroundColor = .black
    }
    
    func generateMovieInfoLabels() -> [UILabel] {
        return movieInfoString.map {
            let label = UILabel()
            label.text = $0
            label.font = .systemFont(ofSize: 15)
            label.textColor = .white.withAlphaComponent(0.8)
            return label
        }
    }
    
    func generateMovieButtons() -> [UIButton] {
        return movieButtonString.map {
            let button = UIButton()
            button.setTitle($0, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 13)
            button.backgroundColor = .blue
            button.layer.cornerRadius = 4
            return button
        }
    }
    
    @objc func go() {
        let vc = SignInViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

