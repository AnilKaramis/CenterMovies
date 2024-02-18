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
    var viewModel: MainViewModel = MainViewModel()
    var cellDataSource: [CenterMoviesViewCell] = []
    
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
        
        
        setupTableView()
        MakeConstraint()
        bindCellDataSource()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Fetch data when the view appears
        viewModel.getData()
        bindIndicator()
    }
    func setupTableView() {
        self.title = "Top Trending Movies"
        self.movieTable.delegate = self
        self.movieTable.dataSource = self
        self.movieTable.backgroundColor = .clear
        
        
        registerCells()
    }
    //    Indicator
    func bindIndicator() {
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
    func bindCellDataSource() {
        viewModel.cellDataSource.bind { [weak self] movies in
            guard let self = self, let movies = movies else {
                return
            }
            self.cellDataSource = movies
            self.reloadTableView()
        }
    }
}
// MARK: - Extensions

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = movieTable.dequeueReusableCell(withIdentifier: MainViewCell.identifier, for: indexPath) as? MainViewCell else {
            return UITableViewCell()
        }
        
        let cellViewModel = cellDataSource[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    // Register table view cells
    func registerCells() {
        self.movieTable.register(MainViewCell.register(), forCellReuseIdentifier: MainViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
    // Reload the table view on the main queue
    func reloadTableView() {
        DispatchQueue.main.async {
            self.movieTable.reloadData()
        }
    }
}


