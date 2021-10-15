//
//  MoviesVC.swift
//  Movies and Series MVVM
//
//  Created by Yiğit Erdinç on 10.10.2021.
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController {

    @IBOutlet var moviesCollectionView: UICollectionView!

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
            UINib(nibName: K.moviesCollectionCellNibName, bundle: nil),
            forCellWithReuseIdentifier: K.moviesCollectionCellReuseIdentifier)

        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self

        setupFlowLayout()
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


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.moviesCollectionCellReuseIdentifier, for: indexPath) as! MoviesCollectionCell
    
        // Configure the cell
    
        return cell
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
