//
//  TmdbApi.swift
//  Movies and Series MVVM
//
//  Created by Yiğit Erdinç on 6.10.2021.
//

import Moya

enum TmdbMethods {
    case getPopularMovies
    case getPopularSeries
    case getMovieDetails
    case getSeriesDetails
}

struct TmdbApi {
    let apiMethods: TmdbMethods
    var page: Int?
    var movieId: Int?
    var seriesId: Int?
}

extension TmdbApi: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }

    var path: String {
        switch apiMethods {
        case .getPopularMovies:
            return "/movie/popular"
        case .getPopularSeries:
            return "/tv/popular"
        case .getMovieDetails:
            return "/movie/\(movieId ?? 0)"
        case .getSeriesDetails:
            return "/tv/\(seriesId ?? 0)"
        }
    }

    var method: Method {
        switch self {
        default:
            return .get
        }
    }

    var task: Task {
        switch apiMethods {
        case .getPopularMovies:
            return .requestParameters(parameters: ["language" : "en-US",
                                                   "page" : "\(page ?? 1)"], encoding: URLEncoding.default)
        case .getPopularSeries:
            return .requestParameters(parameters: ["language" : "en-US",
                                                   "page" : "\(page ?? 1)"], encoding: URLEncoding.default)
        case .getMovieDetails:
            return .requestParameters(parameters: ["language" : "en-US"], encoding: URLEncoding.default)
        case .getSeriesDetails:
            return .requestParameters(parameters: ["language" : "en-US"], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

extension TmdbApi: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
}
