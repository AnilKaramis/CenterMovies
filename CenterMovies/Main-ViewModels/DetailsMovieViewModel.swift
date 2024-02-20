//
//  DetailsMovieViewModel.swift
//  CenterMovies
//
//  Created by AnılKaramış on 19.02.2024.
//

import Foundation
class DetailsMovieViewModel {
    
var movieData: Details
var movieImage: URL?
var movieTitle: String
var movieDescription: String
var movieId: Int

init(movie: Details) {
    self.movieData = movie
    self.movieId = movie.id
    self.movieTitle = movie.title 
    self.movieDescription = movie.overview 
    self.movieImage = makeImageURL(movie.backdropPath)
}
    private func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstant.imageAddress)\(imageCode)")
    }
}
