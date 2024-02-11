//
//  MainViewController.swift
//  CenterMovies
//
//  Created by AnılKaramış on 11.02.2024.
//

import Foundation
import UIKit

class MainViewController:UIViewController {
    //MARK: -Variables
    var viewModel = MainViewModel()
    
    //MARK: - Patterns
    let movieTable:UITableView = {
        var table = UITableView()
        return table
    }()
    let indicatorView : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
//        indicator.startAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(movieTable)
        view.addSubview(indicatorView)
        
        MakeConstraint()
        setupTableView()
    }
    func setupTableView() {
        self.title = "Main View"
        self.movieTable.delegate = self
        self.movieTable.dataSource = self
        registerCells()
    }
//    Indicator
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.indicatorView.startAnimating()
                }
                else {
                    self.indicatorView.stopAnimating()
                }
            }
        }
    }
}
// MARK: - Extensions

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func registerCells() {
        movieTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
