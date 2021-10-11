//
//  MovieDetailsViewModel.swift
//  Movies and Series MVVM
//
//  Created by Yiğit Erdinç on 11.10.2021.
//

import Foundation
import UIKit

struct MovieDetailsViewModel {
    var movieDetails: MovieDetailsModel
}

extension MovieDetailsViewModel {
    var moviePosterImageUrl: URL? {
        return URL(string: movieDetails.posterPath)
    }
    var movieRating: String {
        return "\(movieDetails.voteAverage)"
    }
    var movieName: String {
        return movieDetails.title
    }
    var movieGenres: String {
        return ""
    }
    var movieDuration: String {
        return "\(movieDetails.runtime)"
    }
    var movieReleaseDate: String {
        return movieDetails.releaseDate
    }
    var movieSummary: String {
        return movieDetails.overview
    }
}
