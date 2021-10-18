//
//  NetworkManager.swift
//  Movies and Series MVVM
//
//  Created by Yiğit Erdinç on 6.10.2021.
//

import Moya
import Kingfisher
import UIKit

struct NetworkManager {
    enum FetchPopularRequest {
        case movies(page: Int)
        case series(page: Int)
    }

    enum FetchDetailsRequest {
        case movie(movieId: Int)
        case series(seriesId: Int)
    }

    private var provider = MoyaProvider<TmdbApi>()

    init() {
        let token = Constants.apiToken
        let authPlugin = AccessTokenPlugin { _ in token }
        self.provider = MoyaProvider<TmdbApi>(plugins: [authPlugin])
    }

    func fetchPopular(request: FetchPopularRequest, completion: @escaping (Result<Codable, Error>) -> Void) {
        switch request {
        case .movies(let page):
            provider.request(.init(apiMethods: .getPopularMovies,
                                   page: page)) { moyaResult in
                decodeResult(PopularMoviesModel.self, moyaResult) { (decodeResult) in
                    switch decodeResult {
                    case .success(let decodedModel):
                        completion(.success(decodedModel))
                    case .failure(let decoderError):
                        completion(.failure(decoderError))
                    }
                }
            }

        case .series(let page):
            provider.request(.init(apiMethods: .getPopularSeries,
                                   page: page)) { moyaResult in
                decodeResult(PopularSeriesModel.self, moyaResult) { (decodeResult) in
                    switch decodeResult {
                    case .success(let decodedModel):
                        completion(.success(decodedModel))
                    case .failure(let decoderError):
                        completion(.failure(decoderError))
                    }
                }
            }
        }
    }

    func fetchDetails(request: FetchDetailsRequest, completion: @escaping (Result<Codable, Error>) -> Void) {
        switch request {
        case .movie(let movieId):
            provider.request(.init(apiMethods: .getMovieDetails,
                                   movieId: movieId)) { moyaResult in
                decodeResult(MovieDetailsModel.self, moyaResult) { (decodeResult) in
                    switch decodeResult {
                    case .success(let decodedModel):
                        completion(.success(decodedModel))
                    case .failure(let decoderError):
                        completion(.failure(decoderError))
                    }
                }
            }

        case .series(let seriesId):
            provider.request(.init(apiMethods: .getSeriesDetails,
                                   seriesId: seriesId)) { moyaResult in
                decodeResult(SeriesDetailsModel.self, moyaResult) { (decodeResult) in
                    switch decodeResult {
                    case .success(let decodedModel):
                        completion(.success(decodedModel))
                    case .failure(let decoderError):
                        completion(.failure(decoderError))
                    }
                }
            }
        }
    }

    func fetchMoviesForWidget(completion: @escaping ([PopularMoviesResult]?) -> Void) {
        provider.request(.init(apiMethods: .getPopularMovies, page: 1)) { moyaResult in
            decodeResult(PopularMoviesModel.self, moyaResult) { (decodeResult) in
                switch decodeResult {
                case .success(let model):
                    var movies: [PopularMoviesResult] = []

                    guard let castedModel = model as? PopularMoviesModel else { return }

                    for movie in castedModel.results {
                        movies.append(movie)
                    }
                    completion(movies)
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
        }
    }

    func fetchImage(_ imageUrl: URL?, completion: @escaping ((UIImage) -> Void)) {
        let placeholder = UIImage(named: "doge")!
        if let safeImageUrl = imageUrl {
            let resource = ImageResource(downloadURL: safeImageUrl)
            KingfisherManager.shared.retrieveImage(with: resource) { imageResult in
                switch imageResult {
                case .success(let imageData):
                    completion(imageData.image)
                case .failure(let imageError):
                    print(imageError)
                    completion(placeholder)
                }
            }
        } else {
            completion(placeholder)
        }
    }

    func decodeResult<T: Codable>(_ type: T.Type,
                                  _ result: Result<Response, MoyaError>,
                                  completion: @escaping (Result<Codable, Error>) -> Void) {

        let decoder = JSONDecoder()

        switch result {
        case .success(let response):
            do {
                let filteredResponse = try response.filterSuccessfulStatusCodes()
                let popularMoviesData = try decoder.decode(type.self,
                                                           from: filteredResponse.data)
                completion(.success(popularMoviesData))
            } catch let decodeError {
                print("Error decoding response: \(decodeError.localizedDescription)")
                completion(.failure(decodeError))
            }

        case .failure(let moyaError):
            print("Error getting popular movies data: \(moyaError.localizedDescription)")
            completion(.failure(moyaError))
        }
    }
}
