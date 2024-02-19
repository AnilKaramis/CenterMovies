//
//  TableViewCellModel.swift
//  CenterMovies
//
//  Created by AnılKaramış on 12.02.2024.
//

import Foundation

class CenterMoviesViewCell {
    
    // MARK: - Variables
    
    var id:  Int
    var title: String
    var date: String
    var rating: String
    var imageUrl: URL?
    
    // MARK: - Initializer
    
    init(movie: Details) {
        self.id = movie.id
        self.title = movie.title
        self.date = movie.releaseDate
        self.rating = "\(movie.voteAverage)"
        self.imageUrl = makeImageURL(movie.posterPath)
    }
    
    private func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstant.imageAddress)\(imageCode)")
       
    }
}
// compact map , map , filter , highlvl function
