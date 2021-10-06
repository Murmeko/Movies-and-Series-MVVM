//
//  TmdbApi.swift
//  Movies and Series MVVM
//
//  Created by Yiğit Erdinç on 6.10.2021.
//

import Moya

enum TmdbApi {

    case getPopularMovies(_ page: Int)
    case getPopularSeries(_ page: Int)
    case getMovieDetails(_ movieId: Int)
    case getSeriesDetails(_ seriesId: Int)
}

extension TmdbApi: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }

    var path: String {
        switch self {
        case .getPopularMovies(let page):
            return "/movie/popular&language=en-US&page=\(page)"
        case .getPopularSeries(let page):
            return "/tv/popular&language=en-US&page=\(page)"
        case .getMovieDetails(let movieId):
            return "/movie/\(movieId)&language=en-US"
        case .getSeriesDetails(let seriesId):
            return "/tv/\(seriesId)&language=en-US"
        }
    }

    var method: Method {
        switch self {
        default:
            return .get
        }
    }

    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
