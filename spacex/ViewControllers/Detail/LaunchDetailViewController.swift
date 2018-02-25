//
//  LaunchDetailViewController.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

class LaunchDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var launch: LaunchModel?
    var viewModel: LaunchDetailViewModel?
    var videoHeaderView: LaunchVideoHeaderView?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }

    // MARK: - Build
    func build() {
        if let launch = launch {
            self.viewModel = LaunchDetailViewModel(launch: launch)
        }
        buildTableView()
    }
    
    func buildTableView() {
        tableView.build()
        tableView.register(.launchDetail)
        tableView.register(.launchLink)
        tableView.dataSource = self
        tableView.delegate = self
        
        if let url = viewModel?.videoURL {
            videoHeaderView = LaunchVideoHeaderView.create(videoURL: url)
            tableView.tableHeaderView = videoHeaderView
        }
    }
    
    // MARK: - Action
    @IBAction func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension LaunchDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = viewModel?.tableViewCellType(indexPath: indexPath), let vm = viewModel else {
            return UITableViewCell()
        }
        
        switch type.cellType {
        case .launchLink:
            let cell = tableView.dequeue(type.cellType, indexPath: indexPath)
            if type.cellType == .launchLink {
                (cell as! LaunchLinkTableViewCell).titleLabel.text = type.title
            }
            return cell
        case .launchDetail:
            let cell = tableView.dequeue(type.cellType, indexPath: indexPath, viewModel: vm)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension LaunchDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 1 {
            return nil
        }
        let headerView = TitleHeaderView.create(LaunchDetailViewModel.LaunchDetailTableViewCellType.links.title)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50.0
        }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120.0
        }
        return 45.0
    }
}
