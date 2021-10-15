//
//  MoviesViewModel.swift
//  Movies and Series MVVM
//
//  Created by Yiğit Erdinç on 11.10.2021.
//

import Foundation

class MoviesViewModel {

    private let networkManager = NetworkManager()

    private var currentPage = 1
    private var movieViewModels: [PopularMoviesResult] = []

    var reloadData: (() -> Void)?

    func getMoviesList() {
        let group = DispatchGroup()
        networkManager.fetchPopular(request: .movies(page: currentPage)) { (result) in
            switch result {
            case .success(let data):
                let model = data as? PopularMoviesModel
                guard let safeModel = model else { return }
                for movie in safeModel.results {
                    group.enter()
                    let movieViewModel = PopularMoviesResult(adult: movie.adult,
                                                             backdropPath: movie.backdropPath,
                                                             genreIDS: movie.genreIDS, id: movie.id,
                                                             originalTitle: movie.originalTitle,
                                                             overview: movie.overview,
                                                             popularity: movie.popularity,
                                                             posterPath: movie.posterPath,
                                                             releaseDate: movie.releaseDate,
                                                             title: movie.title,
                                                             video: movie.video,
                                                             voteAverage: movie.voteAverage,
                                                             voteCount: movie.voteCount)

                    self.movieViewModels.append(movieViewModel)
                    group.leave()
                }
                self.currentPage += 1
                group.notify(queue: .main) {
                    self.reloadData!()
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func viewModelCount() -> Int {
        if movieViewModels.isEmpty {
            return 0
        } else {
            return movieViewModels.count
        }
    }

    func getViewModelAtIndexPath(_ indexPath: IndexPath) -> PopularMoviesResult? {
        if movieViewModels.isEmpty {
            return nil
        } else {
            return movieViewModels[indexPath.row]

        }
    }

    init() {
        getMoviesList()
    }
}
