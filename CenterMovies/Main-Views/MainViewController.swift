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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(movieTable)
        
        MakeConstraint()
    }
    func setupTableView() {
        self.title = "Main View"
        self.movieTable.delegate = self
        self.movieTable.dataSource = self
        registerCells()
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
