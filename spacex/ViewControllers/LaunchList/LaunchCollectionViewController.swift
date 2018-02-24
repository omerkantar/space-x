//
//  LaunchCollectionViewController.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

class LaunchCollectionViewController: CommonCollectionViewController {

    var viewModel = LaunchListViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    
    // MARK: - Register
    override func registerCollectionViewCellTypes() -> [UICollectionView.CellType]? {
        return [.launch]
    }
    
    override func refreshingData() {
        self.loadData()
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredCellVMs?.count ?? 0
    }
    
    override func configureCell(indexPath: IndexPath) -> (model: BaseCellViewModel?, type: UICollectionView.CellType)? {
        guard let vm = viewModel.filteredCellVMs?[indexPath.row] else {
            return nil
        }
        return (vm, .launch)
    }
    
    // MARK: - Actions
    @IBAction func filterButtonTapped() {
        if viewModel.allLaunchs == nil {
            return
        }
        let filterVC = self.storyboard?.instantiateViewController(withIdentifier: "filterVC") as! FilterViewController
        filterVC.delegate = self
        self.pushVC(filterVC)
    }
}


// MARK: - UICollectionViewDelegate
extension LaunchCollectionViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}

// MARK: - FilterViewDelegate
extension LaunchCollectionViewController: FilterViewDelegate {
    func filterViewController(_ vc: FilterViewController, didChangedFilter isRemoved: Bool) {
        self.viewModel.updateFilterCellVMs()
        self.collectionView.reloadData()
    }
}

// MARK: - LoadData & Refreshing
extension LaunchCollectionViewController {
    func loadData() {
        self.viewModel.filteredCellVMs?.removeAll()
        self.collectionView.reloadData()
        request(target: .launches, loadingParentView: self.collectionView, success: { (model) in
            self.loadedData(model: model)
        }) { (error, model) in
            
        }
    }
    
    func loadedData(model: ResponseModel) {
        self.viewModel.build(responseModel: model)
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
}
