//
//  TrendViewController.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire

class TrendViewController: UIViewController {
    
    var datas: [Movie]?
    var genres: [Genre]?
    
    let trendTable = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDatas()
        fetchGenres()

        self.configView(isTitled: .isTitled, bgColor: .white, titleText: "Trend")
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: Icons.SEARCH.rawValue), style: .plain, target: self, action: #selector(goToSearchView)), animated: true)
        navigationItem.rightBarButtonItem?.tintColor = .gray
        configTable()
    }
    
    @objc func goToSearchView() {
        navigationController?.pushViewController(SearchMovieViewController(), animated: true)
    }
    
}


extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func configTable() {
        self.view.addSubview(trendTable)
        
        trendTable.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        trendTable.delegate = self
        trendTable.dataSource = self
        trendTable.register(TrendViewCell.self, forCellReuseIdentifier: TrendViewCell.id)
        trendTable.rowHeight = 450
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let datas else { return 0 }
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trendTable.dequeueReusableCell(withIdentifier: TrendViewCell.id, for: indexPath) as! TrendViewCell
        
        guard let datas, let genres else { return UITableViewCell() }
        
        cell.configViewWithData(datas[indexPath.row], genres);
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CastViewController()
        
        guard let datas else { return }
        vc.configViewWithData(movieId: datas[indexPath.row].id)
        
        navigationController?.pushViewController(vc, animated: true)
        trendTable.reloadRows(at: [indexPath], with: .none)
    }
}

extension TrendViewController {
    func fetchGenres() {
        AF.request(APIUrls.TMDB_GENRES, headers: HTTPHeaders([API_HEADERS])).responseDecodable(of: Genres.self) { res in
            switch res.result {
            case .success(let v):
                self.genres = v.genres
                self.trendTable.reloadData()
            case .failure(let e):
                print(e)
            }
        }
    }
    
    func fetchDatas() {
        AF.request(mappingURL(urlType: .trending, trendingType: .week, movieId: nil), headers: HTTPHeaders([API_HEADERS])).responseDecodable(of: MovieResult.self) { res in
            switch res.result {
            case .success(let v):
                self.datas = v.results
                self.trendTable.reloadData()
            case .failure(let e):
                print(e)
            }
        }
    }
}
