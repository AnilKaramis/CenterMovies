//
//  MainViewModel.swift
//  CenterMovies
//
//  Created by AnılKaramış on 11.02.2024.
//

import Foundation
import UIKit

struct MainViewModel {
    var isLoading: Observable <Bool> = Observable(value: false)
    var dataSource: MoviesModel?
    var cellDataSource: Observable<[CenterMoviesViewCell]> = Observable(value: nil)
    
    func numberOfSections() -> Int {
        return 1
    }
    func numberOfRows(in section: Int) -> Int {
        return self.dataSource?.results.count ?? 0
    }
    func getData() {
        APICaller.getCenterMovies { result in
            switch result {
            case .success(let data):
                print("Top Trending Counts:\(data.results.count)")
            case .failure(let error):
                print(error)
            }
        }
    }
}


