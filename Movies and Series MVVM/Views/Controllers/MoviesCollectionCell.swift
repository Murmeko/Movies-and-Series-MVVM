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

    func configure(with viewModel: MovieDetailsViewModel) {
        guard let imageUrl = viewModel.moviePosterImageUrl else { return }
        let imageResource = ImageResource(downloadURL: imageUrl)
        moviesCollectionCellImageView.kf.setImage(with: imageResource)
    }

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
