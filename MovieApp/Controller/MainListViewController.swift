//
//  VCMain.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire

class MainListViewController: BaseViewController {
    private let listTitle = Texts.ListTitle.allCases.map { $0.rawValue }
    private var listDatas:[[Movie]] = [[], [], []]
    
    private let mainView = MainListView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        configureTable()
        fetchAsyncGroup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNav(title: Texts.Title.TITLE_MAIN.rawValue, leftBarItem: nil, rightBarItem: nil)
    }
    
    func fetchAsyncGroup() {
        let serviceType: [APIService.ServiceType] = [.currentPlaying, .trend, .topRated]
        let group = DispatchGroup()
        
        serviceType.enumerated().forEach { (index, type) in
            group.enter()
            DispatchQueue.global().async(group: group) {
                APIService.manager.fetch(type) { (result: MovieResult) in
                    self.listDatas[index] = result.results
                    group.leave()
                } errorHandler: { error in
                    print(error)
                    group.leave()
                }

            }
        }
        
        group.notify(queue: .main) {
            self.mainView.table.reloadSections(IndexSet(integer: 0), with: .none)
        }
    }
}


extension MainListViewController: UITableViewDelegate, UITableViewDataSource{
    private func configureTable() {
        mainView.table.delegate = self
        mainView.table.dataSource = self
        mainView.table.separatorStyle = .none
        mainView.table.register(NormalTableCell.self, forCellReuseIdentifier: NormalTableCell.id)
        mainView.table.rowHeight = 220
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NormalTableCell.id, for: indexPath) as! NormalTableCell
        
        cell.changeTitle(listTitle[indexPath.row])
        cell.collection.delegate = self
        cell.collection.dataSource = self
        cell.collection.register(NormalCollectionItem.self, forCellWithReuseIdentifier: NormalCollectionItem.id)
        cell.collection.tag = indexPath.row
        
        return cell
    }
    
}

extension MainListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listDatas[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCollectionItem.id, for: indexPath) as! NormalCollectionItem
        
        item.configureViewWithData(self.listDatas[collectionView.tag][indexPath.row])
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.configureViewWithData(self.listDatas[collectionView.tag][indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
        collectionView.reloadSections(IndexSet(integer: 0))
    }
}
