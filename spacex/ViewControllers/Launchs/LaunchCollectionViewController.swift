//
//  LaunchCollectionViewController.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

// MARK: - Isimlendirme secerken eger list/collection geciyorsa kelime kokune cogul eki eklemiyorum cunku list anlami coguldur. Or: OgrencilerListesi anlami sanki listenin icinde ogrenciler varmis gibi [["Ali", "Mehmet"], ["Ayse"]] gibi. Ama OgrenciListesi daha tek liste gibi ["Ali", "Mehmet"] olur. Kelime secerken baya detaya indim 🙈

class LaunchCollectionViewController: CommonCollectionViewController {

    var viewModel = LaunchListViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        self.title = "Launchs"
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
        guard let displayLaunchs = viewModel.displayLaunchs else {
            return
        }
        
        let nc = self.storyboard?.instantiateViewController(withIdentifier: "detailNC") as! UINavigationController
        
        if let vc = nc.viewControllers.first as? LaunchDetailViewController {
            vc.launchs = displayLaunchs
            vc.currentIndex = indexPath.row
            present(nc, animated: true, completion: nil)
        }
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
