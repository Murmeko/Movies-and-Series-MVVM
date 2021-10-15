//
//  MoviesCollectionCell.swift
//  Movies and Series MVVM
//
//  Created by Yiğit Erdinç on 10.10.2021.
//

import UIKit
import Kingfisher

class MoviesCollectionCell: UICollectionViewCell {
    @IBOutlet weak var moviesCollectionCellImageView: UIImageView!
    @IBOutlet weak var moviesCollectionCellMovieNameLabel: UILabel!
    @IBOutlet weak var moviesCollectionCellGenreNamesLabel: UILabel!
    @IBOutlet weak var moviesCollectionCellReleaseDateLabel: UILabel!
    @IBOutlet weak var moviesCollectionCellRatingLabel: UILabel!

    func configure(with viewModel: PopularMoviesResult?) {

        if let safeViewModel = viewModel {
            let imageUrl = URL(string: "https://www.themoviedb.org/t/p/w1280\(safeViewModel.posterPath)")
            guard let safeImageUrl = imageUrl else { return }
            let imageResource = ImageResource(downloadURL: safeImageUrl)
            moviesCollectionCellImageView.kf.setImage(with: imageResource)
            moviesCollectionCellMovieNameLabel.text = safeViewModel.title
            moviesCollectionCellGenreNamesLabel.text = ""
            moviesCollectionCellReleaseDateLabel.text = safeViewModel.releaseDate
            moviesCollectionCellRatingLabel.text = "\(safeViewModel.voteAverage)"
        } else {

        }
    }

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
