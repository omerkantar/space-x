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
    
    var cellVMs = [LaunchCellViewModel]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTableView()
        
    }

    func buildTableView() {
        
        for _ in 0..<30 {
            cellVMs.append(LaunchCellViewModel())
        }
        
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
        return cellVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = cellVMs[indexPath.row]
        let cell = tableView.dequeue(.launch, indexPath: indexPath, viewModel: vm)
        return cell
    }
}
// MARK: - UITableViewDelegate
extension LaunchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245.0
    }
}

// MARK: - Load Data
extension LaunchListViewController {
    func loadData() {
        
    }
}
