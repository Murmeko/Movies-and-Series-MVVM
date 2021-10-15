//
//  MoviesVC.swift
//  Movies and Series MVVM
//
//  Created by Yiğit Erdinç on 10.10.2021.
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController {

    @IBOutlet var moviesCollectionView: UICollectionView!

    let moviesViewModel = MoviesViewModel()

    func setupFlowLayout() {
        if let flowLayout = moviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 10
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            let moviesCollectionViewCellHeight = moviesCollectionView.bounds.width - 20
            let moviesCollectionViewCellWidth = moviesCollectionViewCellHeight / 2
            let size = CGSize(width: moviesCollectionViewCellHeight, height: moviesCollectionViewCellWidth)
            flowLayout.itemSize = size
        }
    }

    func setupCollectionView() {
        moviesCollectionView.register(
            UINib(nibName: Constants.moviesCollectionCellNibName, bundle: nil),
            forCellWithReuseIdentifier: Constants.moviesCollectionCellReuseIdentifier)

        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self

        setupFlowLayout()
        moviesViewModel.reloadData = { DispatchQueue.main.async {
            self.moviesCollectionView.reloadData()
        }}
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return moviesViewModel.viewModelCount()
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.moviesCollectionCellReuseIdentifier,
            for: indexPath) as! MoviesCollectionCell

        cell.configure(with: moviesViewModel.getViewModelAtIndexPath(indexPath))
        return cell
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            moviesViewModel.getMoviesList()
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
