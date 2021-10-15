//
//  PopularMoviesProvider.swift
//  PopularMoviesWidgetExtension
//
//  Created by Yiğit Erdinç on 14.10.2021.
//

import Foundation
import WidgetKit
import UIKit

struct PopularMoviesProvider: TimelineProvider {

    typealias Entry = MovieEntry

    let networkManager = NetworkManager()

    func placeholder(in context: Context) -> MovieEntry {
        MovieEntry.placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (MovieEntry) -> Void) {

        if context.isPreview {
            completion(MovieEntry.placeholder)
        } else {
            networkManager.fetchPopular(request: .movies(page: 1)) { (result) in

                switch result {
                case .success(let model):
                    let castedModel = model as? PopularMoviesModel
                    let entry = MovieEntry(date: Date(),
                                           movieName: castedModel?.results[9].title ?? "Error",
                                           moviePosterUrlString: "https://www.themoviedb.org/t/p/w1280\(String(describing: castedModel?.results[9].posterPath))")
                    completion(entry)

                case .failure(_):
                    completion(MovieEntry.placeholder)
                }
            }
        }
    }

    func getMovies(completion: @escaping (([MovieEntry]) -> Void)) {
            networkManager.fetchPopular(request: .movies(page: 1)) { (result) in
                switch result {
                case .success(let model):
                    var movies: [MovieEntry] = []
                    guard let castedModel = model as? PopularMoviesModel else { return }

                    let group = DispatchGroup()
                    let currentDate = Date()
                    var index = 0
                    for movie in castedModel.results {
                        group.enter()
                        index+=1
                        let entry = MovieEntry(date: Calendar.current.date(byAdding: .minute,
                                                                           value: index,
                                                                           to: currentDate)!,
                                               movieName: movie.title,
                                               moviePosterUrlString: "https://www.themoviedb.org/t/p/w1280\(movie.posterPath)")
                        movies.append(entry)
                        group.leave()
                    }
                    group.notify(queue: .main) {
                        completion(movies)
                    }
                case .failure(_):
                    let movies = [MovieEntry.placeholder]
                    completion(movies)
                }
            }
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<MovieEntry>) -> Void) {
        getMovies { movies in
            var entries = movies
            let timeline = Timeline(entries: movies, policy: .atEnd)
            print(timeline.entries)
            completion(timeline)
        }
    }
}
