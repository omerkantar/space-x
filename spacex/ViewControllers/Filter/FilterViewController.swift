//
//  FilterViewController.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

protocol FilterViewDelegate: NSObjectProtocol {
    func filterViewController(_ vc: FilterViewController, didChangedFilter isRemoved: Bool) -> Void
}

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var removeFilterButton: UIButton!
    
    var viewModel: FilterViewModel = FilterViewModel()
    var changedFilter: Bool = false
    weak var delegate: FilterViewDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            if let headerView = self.tableView.tableHeaderView {
                headerView.frame.size.height = 1.0
                self.tableView.tableHeaderView = headerView
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if changedFilter {
            changedFilter = false
            if let delegate = delegate {
                delegate.filterViewController(self, didChangedFilter: false)
            }
        }
    }

    // MARK: - Build
    func buildTableView() {
        viewModel.build()
        tableView.build()
        tableView.register(.filter)
        tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 55.0, 0.0)
        tableView.dataSource = self
        tableView.delegate = self
        showBottomViewIfNeeded()
    }
    
    func showBottomViewIfNeeded() {
        self.bottomView.isHidden = FilterManager.sharedInstance.isClearFilter()
    }
    
    // MARK: - Actions
    @IBAction func removeFilterButtonTapped() {
        FilterManager.sharedInstance.filteredModel.remove()
        viewModel.build()
        tableView.reloadData()
        if let delegate = delegate {
            delegate.filterViewController(self, didChangedFilter: true)
        }
        self.popVC()
    }
    

}

// MARK: - UITableViewDataSource
extension FilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel.cellViewModel(indexPath: indexPath) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeue(.filter, indexPath: indexPath, viewModel: vm)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel.isSortViewModel(indexPath: IndexPath(row: 0, section: section)) {
            return "SORT BY DATE"
        }
        return "FILTER YEARS"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectedCell(indexPath: indexPath)
        tableView.reloadData()
        changedFilter = true
        tableView.reloadData()
        showBottomViewIfNeeded()
        BlurMessageView.show(title: "Successful filter updated, you can go to back, launchs screens. 🚀") { (title) in
            self.popVC()
        }
    }
}
