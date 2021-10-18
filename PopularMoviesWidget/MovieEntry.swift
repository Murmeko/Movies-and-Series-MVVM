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
    let posterImage: UIImage

    var isPlaceholder = false
}
extension MovieEntry {
    static var stub: MovieEntry {
        MovieEntry(date: Date(), movieName: "Hello There!",
                   posterImage: UIImage(named: "doge")!)
    }

    static var placeholder: MovieEntry {
        MovieEntry(date: Date(), movieName: "Hello There!",
                   posterImage: UIImage(named: "doge")!,
                   isPlaceholder: true)
    }
}
