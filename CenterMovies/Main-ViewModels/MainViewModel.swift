//
//  MainViewModel.swift
//  CenterMovies
//
//  Created by AnılKaramış on 11.02.2024.
//

import Foundation
import UIKit

// You have to change MainViewModel to class (mistake on the side of [weak self] )

class MainViewModel {
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
        if isLoading.value ?? true {
            return
        }
        
        isLoading.value = true
        APICaller.getCenterMovies { [weak self] result in
            self?.isLoading.value = false
            
            switch result {
            case .success(let trendingMovieData):
                self?.dataSource = trendingMovieData
                self?.mapMovieData()
            case .failure(let error):
                print(error)
            }
        }
    }
//        APICaller.getCenterMovies { result in
//            switch result {
//            case .success(let data):
//                print("Top Trending Counts:\(data.results.count)")
//            case .failure(let error):
//                print(error)
//            }
//        }
    private func mapMovieData() {
        cellDataSource.value = self.dataSource?.results.compactMap({CenterMoviesViewCell(movie: $0)})
    }
    func getMovieTitle(_ movie: Details) -> String {
        return movie.title
    }
    func retriveMovie(withId id: Int) -> Details? {
        guard let movie = dataSource?.results.first(where: {$0.id == id}) else {
            return nil
        }
        return movie
    }
}

