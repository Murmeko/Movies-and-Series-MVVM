//
//  NetworkImage.swift
//  Movies and Series MVVM
//
//  Created by Yiğit Erdinç on 15.10.2021.
//

import SwiftUI

struct NetworkImage: View {
    let url: URL?
    var body: some View {

        Group {
            if let url = url, let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Image("placeholder-image")
            }
        }
    }
}
