//
//  NetworkManager.swift
//  Movies and Series MVVM
//
//  Created by Yiğit Erdinç on 6.10.2021.
//

import Moya
import Kingfisher

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
                                   page: page)) { result in
                decodeResult(PopularMoviesModel.self, result) { (result) in
                    switch result {
                    case .success(let decodedModel):
                        completion(.success(decodedModel))
                    case .failure(let decoderError):
                        completion(.failure(decoderError))
                    }
                }
            }

        case .series(let page):
            provider.request(.init(apiMethods: .getPopularSeries,
                                   page: page)) { result in
                decodeResult(PopularSeriesModel.self, result) { (result) in
                    switch result {
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
                                   movieId: movieId)) { result in
                decodeResult(MovieDetailsModel.self, result) { (result) in
                    switch result {
                    case .success(let decodedModel):
                        completion(.success(decodedModel))
                    case .failure(let decoderError):
                        completion(.failure(decoderError))
                    }
                }
            }

        case .series(let seriesId):
            provider.request(.init(apiMethods: .getSeriesDetails,
                                   seriesId: seriesId)) { result in
                decodeResult(SeriesDetailsModel.self, result) { (result) in
                    switch result {
                    case .success(let decodedModel):
                        completion(.success(decodedModel))
                    case .failure(let decoderError):
                        completion(.failure(decoderError))
                    }
                }
            }
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
