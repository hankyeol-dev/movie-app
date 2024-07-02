//
//  TestViewController.swift
//  MovieApp
//
//  Created by 강한결 on 7/1/24.
//

import UIKit
import Toast

final class TestViewController: BaseViewController {
    private var movieList: [Movie] = []
    private var session = URLSession(configuration: .default)
    
    private let mainView = TestView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configurePicker()
        mainView.button.addTarget(self, action: #selector(getMovieImages), for: .touchUpInside)
        
        APIService.manager.fetch(.currentPlaying) { (data: MovieResult) in
            self.movieList = data.results
        } errorHandler: { error in
            print(error)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNav(title: "TEST", leftBarItem: nil, rightBarItem: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainView.onChangeButtonDisable()
    }
}

extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    private func configureTable() {
        mainView.table.delegate = self
        mainView.table.dataSource = self
        mainView.table.rowHeight = 200
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension TestViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    private func configurePicker() {
        let picker = UIPickerView()
        mainView.field.inputView = picker
        picker.delegate = self
        picker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.movieList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.movieList[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.mainView.field.text = self.movieList[row].title
        self.mainView.button.tag = self.movieList[row].id
        self.mainView.onChangeButtonEnable()
        view.endEditing(true)
    }
}

extension TestViewController: URLSessionDelegate, URLSessionDataDelegate {
    
    @objc
    func getMovieImages(_ sender: UIButton) {
        var request = URLRequest(url: URL(string: genImageURL(movieId: sender.tag))!)
        
        request.allHTTPHeaderFields = [
            "Authorization": AUTHORIZATION
        ]
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: request).resume()
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        if let res = response as? HTTPURLResponse, (200...299).contains(res.statusCode) {
            print(res)
            return .allow
        } else {
            view.makeToast("뭔가 문제가 발생했어요 😅", duration: 3)
            return .cancel
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(data)
    }
    
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        print(error)
    }
}
