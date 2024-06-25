//
//  VCMain.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire

class VCMain: VCBase {
    
    private let mainView = VMain()
    var datas: [[Movie]] = ApiService.ServiceType.allCases.map { _ in return [] }
    
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
        let group = DispatchGroup()
        
        ApiService.ServiceType.allCases.enumerated().forEach { (idx, v) in
            group.enter()
            DispatchQueue.global().async(group: group) {
                ApiService.manager.fetch(v, movieId: 423502) { (data: MovieResult) in
                    self.datas[idx] = data.results
                    group.leave()
                }
                
            }
        }
        
        
        group.notify(queue: .main) {
            print(self.datas)
            self.mainView.table.reloadSections(IndexSet(integer: 0), with: .none)
        }
    }
}


extension VCMain: UITableViewDelegate, UITableViewDataSource{
    private func configureTable() {
        mainView.table.delegate = self
        mainView.table.dataSource = self
        mainView.table.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.id)
        mainView.table.register(NormalTableViewCell.self, forCellReuseIdentifier: NormalTableViewCell.id)
        mainView.table.separatorStyle = .none
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApiService.ServiceType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.id, for: indexPath) as! CardTableViewCell
            cell.collection.tag = indexPath.row
            cell.label.changeText(ApiService.ServiceType.allCases[indexPath.row].rawValue)
            cell.collection.delegate = self
            cell.collection.dataSource = self
            cell.collection.register(VMainCollectionItemCard.self, forCellWithReuseIdentifier: VMainCollectionItemCard.id)
            cell.collection.reloadSections(IndexSet(integer: 0))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NormalTableViewCell.id, for: indexPath) as! NormalTableViewCell
            cell.collection.tag = indexPath.row
            cell.label.changeText(ApiService.ServiceType.allCases[indexPath.row].rawValue)
            cell.collection.delegate = self
            cell.collection.dataSource = self
            cell.collection.register(VMainCollectionItemNormal.self, forCellWithReuseIdentifier: VMainCollectionItemNormal.id)
            cell.collection.reloadSections(IndexSet(integer: 0))
            return cell
        }
    }
    
}

extension VCMain: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.datas[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: VMainCollectionItemCard.id, for: indexPath) as! VMainCollectionItemCard
            
            item.configureViewWithData(datas[collectionView.tag][indexPath.row])
            
            return item
        } else {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: VMainCollectionItemNormal.id, for: indexPath) as! VMainCollectionItemNormal
            
            item.configureViewWithData(datas[collectionView.tag][indexPath.row])
            
            return item
        }
    }
}
