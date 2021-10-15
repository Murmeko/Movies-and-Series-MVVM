//
//  PopularMoviesWidget.swift
//  PopularMoviesWidget
//
//  Created by Yiğit Erdinç on 13.10.2021.
//

import WidgetKit
import SwiftUI

struct PopularMoviesWidgetEntryView : View {

    var entry: MovieEntry

    var body: some View {

        ZStack(alignment: .topTrailing) {

            NetworkImage(url: URL(string: entry.moviePosterUrlString))

            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom).opacity(0.5)

            VStack() {
                VStack() {
                    Image("tmdbLogo").resizable().frame(width: 30, height: 30, alignment: .center).padding(.trailing, 10).padding(.top, 10)
                }.frame(minWidth: 0,
                        maxWidth: .infinity,
                        alignment: .trailing)

                Spacer()

                VStack(alignment: .center) {
                    Text(entry.movieName).foregroundColor(.white).bold().multilineTextAlignment(.center).lineLimit(3).padding(.bottom, 10)
                }.frame(minWidth: 0,
                        maxWidth: .infinity,
                        alignment: .center)
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center)
        }
    }
}

@main
struct PopularMoviesWidget: Widget {
    let kind: String = "PopularMoviesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PopularMoviesProvider()) { entry in
            PopularMoviesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Popular Movies")
        .description("A simple widget that shows popular movies.")
        .supportedFamilies([WidgetFamily.systemSmall])
    }
}

struct PopularMoviesWidget_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesWidgetEntryView(entry: MovieEntry.stub)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
