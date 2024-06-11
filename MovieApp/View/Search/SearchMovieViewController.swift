//
//  SearchMovieViewController.swift
//  MovieApp
//
//  Created by 강한결 on 6/11/24.
//

import UIKit
import SnapKit
import Alamofire

class SearchMovieViewController: UIViewController {
    var datas: [Searched] = []
    var page: Int = 1
    var viewSegmentIndex = 0
    
    let search = UISearchBar()
    let searchedCollection = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width * 0.85
        let height = UIScreen.main.bounds.height * 0.7
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = .black
        return c
    }()
    let table = UITableView()
    
    let segmentStack = UIStackView()
    let segmentTableView = UIButton()
    let segmentCollectionView = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView(isTitled: .isTitled, bgColor: .white, titleText: "영화 검색")
        
        configAddSubview()
        configLayout()
        configSearchBar()
        configSegmentStack()
    }

}

extension SearchMovieViewController {
    func fetchSearchDataByQuery(_ query: String) {
        let url = APIUrls.TMDB_SEARCH + "query=\(query)&page=\(String(self.page))"
        AF.request(url, headers: HTTPHeaders([API_HEADERS])).responseDecodable(of: SearchedResult.self) { res in
            switch res.result {
            case .success(let v):
                if self.datas.count == 0 {
                    self.datas = v.results
                } else {
                    self.datas.append(contentsOf: v.results)
                }
                self.searchedCollection.reloadSections(IndexSet(integer: 0))
                self.table.reloadSections(IndexSet(integer: 0), with: .none)
            case .failure(let e):
                print(e)
            }
        }
    }
}

extension SearchMovieViewController {
    func configAddSubview() {
        view.addSubview(search)
        view.addSubview(segmentStack)
        segmentStack.addArrangedSubview(segmentTableView)
        segmentStack.addArrangedSubview(segmentCollectionView)
    }
    
    func configLayout() {
        search.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(56)
        }
        segmentStack.snp.makeConstraints { make in
            make.top.equalTo(search.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        segmentTableView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
        }
        segmentCollectionView.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview()
        }
        
        if self.viewSegmentIndex == 0 {
            selectTableViewLayout()
        } else {
            selectCollectionViewLayout()
        }
    }
    
    func selectCollectionViewLayout() {
        view.addSubview(searchedCollection)
        searchedCollection.snp.makeConstraints { make in
            make.top.equalTo(segmentStack.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        configCollectionView()
    }
    
    func selectTableViewLayout() {
        view.addSubview(table)
        table.snp.makeConstraints { make in
            make.top.equalTo(segmentStack.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        configTable()
    }
    
    func configSegmentStack() {
        segmentStack.axis = .horizontal
        segmentStack.spacing = 8
        segmentStack.distribution = .fillEqually
        
        segmentTableView.tag = 0
        segmentTableView.setTitle("테이블 뷰로 보기", for: .normal)
        segmentTableView.addTarget(self, action: #selector(changeLayout), for: .touchUpInside)
        segmentTableView.backgroundColor = .black
        
        segmentCollectionView.tag = 1
        segmentCollectionView.setTitle("컬랙션 뷰로 보기", for: .normal)
        segmentCollectionView.addTarget(self, action: #selector(changeLayout), for: .touchUpInside)
        segmentCollectionView.backgroundColor = .blue
    }
    
    @objc func changeLayout(_ sender: UIButton) {
        self.viewSegmentIndex = sender.tag
        self.viewDidLoad()
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    func configSearchBar() {
        search.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.datas = []
            self.searchedCollection.reloadSections(IndexSet(integer: 0))
            self.table.reloadSections(IndexSet(integer: 0), with: .none)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.fetchSearchDataByQuery(text)
        
    }
    
    
}

extension SearchMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func configCollectionView() {
        searchedCollection.delegate = self
        searchedCollection.dataSource = self
        searchedCollection.register(SearchedItem.self, forCellWithReuseIdentifier: SearchedItem.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: SearchedItem.id, for: indexPath) as! SearchedItem
        
        item.configViewWithData(self.datas[indexPath.row])
        
        return item
    }
    
}

extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func configTable() {
        table.delegate = self
        table.dataSource = self
        table.prefetchDataSource = self
        table.register(SearchedItemTableCell.self, forCellReuseIdentifier: SearchedItemTableCell.id)
        table.rowHeight = 56
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: SearchedItemTableCell.id, for: indexPath) as! SearchedItemTableCell
        
        cell.configTitleLabelByData(self.datas[indexPath.row].title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for i in indexPaths {
            if datas.count - 5 == i.row {
                self.page += 1
                self.fetchSearchDataByQuery(search.text ?? "")
            }
        }
    }
}
