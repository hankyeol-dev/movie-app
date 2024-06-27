//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import UIKit
import SnapKit


class MovieDetailViewController: BaseViewController {
    private var movieId = 0
    private var crews: MovieCrew = MovieCrew(name: "", job: "", profile_path: "")
    private var castings: [MovieCast] = {
        var array: [MovieCast] = []
        for i in 0...4 {
            array += [MovieCast(name: "", character: "", order: 0, profile_path: "")]
        }
        return array
    } ()
    
    private let mainView = MovieDetailView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVCData()
        configureCollectionView()
    }

}

extension MovieDetailViewController {
    func configureViewWithData(_ movieId: Int) {
        self.movieId = movieId
    }
    
    func fetchVCData() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APIService.manager.fetch(.detail(id: self.movieId)) { (data: MovieDetail) in
                self.configureNav(title: data.title, leftBarItem: self.genLeftWithGoBack(), rightBarItem: nil)
                self.mainView.configureViewWithData(
                    data,
                    userRating: UserDefaultService.manager.getMovieRateById(movieId: data.id)
                )
                group.leave()
            } errorHandler: { error in
                print(error)
                group.leave()
            }
        }
       
        group.enter()
        DispatchQueue.global().async(group: group) {
            APIService.manager.fetch(.credit(id: self.movieId)) { (data: MovieCastResult) in
                self.crews = data.getDirector
                self.castings = data.getFiveActors
                group.leave()
            } errorHandler: { error in
                print(error)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.mainView.casting.castingCollection.reloadSections(IndexSet(integer: 0))
            self.mainView.casting.directorCollection.reloadSections(IndexSet(integer: 0))
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func configureCollectionView() {
        let directing = mainView.casting.directorCollection
        let casting = mainView.casting.castingCollection
        
        [directing, casting].forEach {
            $0.delegate = self
            $0.dataSource = self
            $0.register(MovieDetailCastingItem.self, forCellWithReuseIdentifier: MovieDetailCastingItem.id)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == mainView.casting.directorCollection ? 1 : 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailCastingItem.id, for: indexPath) as! MovieDetailCastingItem
        
        if collectionView == mainView.casting.directorCollection {
            item.configureViewWithData(self.crews)
        } else {
            item.configureViewWithData(self.castings[indexPath.row])
        }
        
        return item
    }
    
    
}
