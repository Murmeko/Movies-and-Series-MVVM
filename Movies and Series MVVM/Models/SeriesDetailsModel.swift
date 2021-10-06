//
//  SeriesDetailsModel.swift
//  Movies and Series MVVM
//
//  Created by Yiğit Erdinç on 6.10.2021.
//

import Foundation

// MARK: - SeriesDetailsModel
struct SeriesDetailsModel: Codable {

    let backdropPath: String
    let episodeRunTime: [Int]
    let firstAirDate: String
    let genres: [SeriesGenre]
    let homepage: String
    let id: Int
    let inProduction: Bool
    let languages: [String]
    let lastAirDate: String
    let name: String
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let originCountry: [String]
    let originalLanguage: String
    let originalName: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let status: String
    let tagline: String
    let type: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {

        case backdropPath = "backdrop_path"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres
        case homepage
        case id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case name
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case popularity
        case posterPath = "poster_path"
        case status
        case tagline
        case type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - SeriesGenres
struct SeriesGenre: Codable {

    let id: Int
    let name: String
}
