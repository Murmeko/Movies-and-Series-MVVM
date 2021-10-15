//
//  MovieEntry.swift
//  PopularMoviesWidgetExtension
//
//  Created by Yiğit Erdinç on 14.10.2021.
//

import Foundation
import WidgetKit
import SwiftUI

struct MovieEntry: TimelineEntry {
    var date: Date

    let movieName: String
    let moviePosterUrlString: String

    var isPlaceholder = false
}
extension MovieEntry {
    static var stub: MovieEntry {
        MovieEntry(date: Date(), movieName: "Hello There!",
                   moviePosterUrlString: "https://i.kym-cdn.com/entries/icons/original/000/013/564/doge.jpg")
    }

    static var placeholder: MovieEntry {
        MovieEntry(date: Date(), movieName: "Hello There!",
                   moviePosterUrlString: "https://i.kym-cdn.com/entries/icons/original/000/013/564/doge.jpg",
                   isPlaceholder: true)
    }
}
