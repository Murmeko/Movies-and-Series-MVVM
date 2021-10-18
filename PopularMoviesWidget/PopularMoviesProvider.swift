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
        return MovieEntry.placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (MovieEntry) -> Void) {
        if context.isPreview {
            completion(MovieEntry.placeholder)
        } else {
            networkManager.fetchPopular(request: .movies(page: 1)) { (result) in
                switch result {
                case .success(let model):
                    let castedModel = model as? PopularMoviesModel
                    let imageUrl = URL(string: "https://www.themoviedb.org/t/p/w1280\(String(describing: castedModel?.results[0].posterPath))")
                    networkManager.fetchImage(imageUrl) { image in
                        let entry = MovieEntry(date: Date(),
                                               movieName: castedModel?.results[0].title ?? "Error",
                                               posterImage: image)
                        completion(entry)
                    }

                case .failure(_):
                    completion(MovieEntry.placeholder)
                }
            }
        }
    }

    func getEntries(completion: @escaping (([MovieEntry]) -> Void)) {
        networkManager.fetchMoviesForWidget { movies in
            if let safeMovies = movies {
                let currentDate = Date()
                var entries: [MovieEntry] = []
                var currentEntry = 0
                for movie in safeMovies {
                    let imageUrl = URL(string: "https://www.themoviedb.org/t/p/w300\(movie.posterPath)")
                    networkManager.fetchImage(imageUrl) { image in
                        let entry = MovieEntry(date: currentDate.addingTimeInterval(TimeInterval(currentEntry)), movieName: movie.title, posterImage: image)
                        entries.append(entry)
                        currentEntry += 1
                    }
                }
                completion(entries)
            } else {
                completion([MovieEntry.placeholder])
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MovieEntry>) -> Void) {
        getEntries { results in
            let timeline = Timeline(entries: results, policy: .atEnd)
            completion(timeline)
        }
    }
}
