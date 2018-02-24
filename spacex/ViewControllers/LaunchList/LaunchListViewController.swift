//
//  LaunchListViewController.swift
//  spacex
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

// MARK: - Isimlendirme secerken eger list geciyorsa kelime kokune cogul eki eklemiyorum cunku list anlami coguldur. Or: OgrencilerListesi anlami sanki listenin icinde ogrenciler varmis gibi [["Ali", "Mehmet"], ["Ayse"]] gibi. Ama OgrenciListesi daha tek liste gibi ["Ali", "Mehmet"] olur. Kelime secerken baya detaya indim 🙈

class LaunchListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = LaunchListViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTableView()
        loadData()
    }

    func buildTableView() {
    
        tableView.build()
        tableView.register(.launch)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }


}

// MARK: - UITableViewDataSource
extension LaunchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCellVMs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.filteredCellVMs?[indexPath.row]
        let cell = tableView.dequeue(.launch, indexPath: indexPath, viewModel: vm)
        return cell
    }
}
// MARK: - UITableViewDelegate
extension LaunchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185.0
    }
}

// MARK: - Load Data
extension LaunchListViewController {
    func loadData() {
        request(target: .launches, loadingParentView: self.tableView, success: { (model) in
            self.loadedData(model: model)
        }) { (error, model) in
            
        }
    }
    
    func loadedData(model: ResponseModel) {
        self.viewModel.build(responseModel: model)
        self.tableView.reloadData()
    }
}
