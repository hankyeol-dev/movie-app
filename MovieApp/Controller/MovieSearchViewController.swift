//
//  MovieSearchViewController.swift
//  MovieApp
//
//  Created by 강한결 on 6/28/24.
//

import UIKit

class MovieSearchViewController: BaseViewController {
    private var datas: [Movie] = []
    private let mainView = MovieSearchView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTXF()
        configureAddAction()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNav(title: Texts.Title.TITLE_MOVIE_SEARCH.rawValue, leftBarItem: self.genLeftWithGoBack(), rightBarItem: nil)
    }
    
}

extension MovieSearchViewController {
    func configureAddAction() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addKeyboardDownGesture)))
        self.mainView.header.searchButton.addTarget(self, action: #selector(searchMovie), for: .touchUpInside)
    }
    
    @objc
    func addKeyboardDownGesture() {
        self.view.endEditing(true)
    }
    
    @objc
    func searchMovie() {
        self.view.endEditing(true)
        guard let text = self.mainView.header.searchBar.text else { return }
        guard let formattingQuery = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        APIService.manager.fetch(.searching(query: formattingQuery)) { (data: MovieResult) in
            self.mainView.configureSuccessView()
            self.datas = data.results
            DispatchQueue.main.async {
                self.mainView.table.reloadSections(IndexSet(integer: 0), with: .none)
            }
        } errorHandler: { error in
            self.mainView.configureErrorView()
        }

    }
}

extension MovieSearchViewController: UITextFieldDelegate {
    func configureTXF() {
        self.mainView.header.searchBar.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.mainView.header.moveOutTextOnTextfield()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        do {
            try ValidateService.manager.validateSearch(text)
            self.mainView.header.changeSearchButtonConfig(.searching)
        } catch {
            self.mainView.header.changeSearchButtonConfig(.notSearching)
        }
        
    }
}

extension MovieSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        self.mainView.table.delegate = self
        self.mainView.table.dataSource = self
        self.mainView.table.register(MovieSearchItem.self, forCellReuseIdentifier: MovieSearchItem.id)
        self.mainView.table.rowHeight = 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchItem.id, for: indexPath) as! MovieSearchItem
        
        cell.configureViewWithData(self.datas[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        
        vc.configureViewWithData(self.datas[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
}
