//
//  NetworkManager.swift
//  Movies and Series MVVM
//
//  Created by Yiğit Erdinç on 6.10.2021.
//

import Moya

struct NetworkManager {
    enum FetchRequest {
        case popularMovies(page: Int)
        case popularSeries(page: Int)
        case movieDetails(movieId: Int)
        case seriesDetails(seriesId: Int)
    }

    private var provider = MoyaProvider<TmdbApi>()

    init(token: String) {
        let authPlugin = AccessTokenPlugin { _ in token }
        self.provider = MoyaProvider<TmdbApi>(plugins: [authPlugin])
    }

    func fetch(request: FetchRequest, completion: @escaping (Codable?) -> Void) {
        switch request {
        case .popularMovies(let page):
            provider.request(.init(apiMethods: .getPopularMovies,
                                   page: page)) { result in
                decodeResult(PopularMoviesModel.self, result) { model in
                    completion(model)
                }
            }
        case .popularSeries(let page):
            provider.request(.init(apiMethods: .getPopularSeries,
                                   page: page)) { result in
                decodeResult(SeriesDetailsModel.self, result) { model in
                    completion(model)
                }
            }
        case .movieDetails(let movieId):
            provider.request(.init(apiMethods: .getMovieDetails,
                                   movieId: movieId)) { result in
                decodeResult(SeriesDetailsModel.self, result) { model in
                    completion(model)
                }
            }
        case .seriesDetails(let seriesId):
            provider.request(.init(apiMethods: .getSeriesDetails,
                                   seriesId: seriesId)) { result in
                decodeResult(SeriesDetailsModel.self, result) { model in
                    completion(model)
                }
            }
        }
    }

    func decodeResult<T: Decodable>(_ type: T.Type,
                                    _ result: Result<Response, MoyaError>,
                                    completion: @escaping (T?) -> Void) {
        let decoder = JSONDecoder()
        switch result {
        case .success(let response):
            do {
                print(response.statusCode)
                let filteredResponse = try response.filterSuccessfulStatusCodes()
                print(filteredResponse)
                let popularMoviesData = try decoder.decode(type.self,
                                                           from: filteredResponse.data)
                completion(popularMoviesData)
            } catch let decoderError {
                print("Error decoding response: \(decoderError.localizedDescription)")
                completion(nil)
            }
        case .failure(let moyaError):
            print("Error getting popular movies data: \(moyaError.localizedDescription)")
            completion(nil)
        }
    }
}
