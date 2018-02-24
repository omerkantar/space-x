//
//  CommonCollectionViewController.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit


// MARK: - Bu class collection view kullanilacak view controller'larin base class'i olup code tekrarini onlenecektir.
//

class CommonCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellSize: CGSize = .zero
    
    var numberOfCellsOnLine: Int = 3
    
    var refreshControl = UIRefreshControl()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildCollectionView()
    }
    
    // MARK: - Build
    func buildCollectionView() {
        if let list = registerCollectionViewCellTypes() {
            collectionView.register(list)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: UIControlEvents.valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func refreshControlValueChanged() {
        refreshingData()
    }
    
    func refreshingData() {
        
    }
    
    // MARK: - Collection View Register
    func registerCollectionViewCellTypes() -> [UICollectionView.CellType]? {
        return nil
    }

    // MARK: - Collection View Cell Configuration
    func configureCell(indexPath: IndexPath) -> (model: BaseCellViewModel?, type: UICollectionView.CellType)? {
        return nil
    }
    
}

// MARK: - UICollectionViewDataSource
extension CommonCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let configure = configureCell(indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeue(configure.type, indexPath: indexPath, viewModel: configure.model)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CommonCollectionViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CommonCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if cellSize != .zero {
            return cellSize
        }
        let width: CGFloat = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let cellWidth: CGFloat = width / CGFloat(numberOfCellsOnLine)
        cellSize = CGSize(width: cellWidth, height: cellWidth * 3/2)
        
        return cellSize
    }
}

