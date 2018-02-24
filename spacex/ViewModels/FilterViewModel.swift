//
//  FilterViewModel.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

class FilterViewModel: NSObject {

    let manager = FilterManager.sharedInstance
    var yearCellVMs: [FilterCellViewModel]?
    var sortCellVMs: [FilterCellViewModel]?
    
    func build() {
        buildYearsFilterCVMs()
        buildSortFilterCVMs()
    }
    
    
    fileprivate func buildYearsFilterCVMs() {
        let years = manager.model.years
        let selectedYears = manager.filteredModel.years
        if years.count > 0 {
            self.yearCellVMs = [FilterCellViewModel]()
            for year in years {
                let isChecked = selectedYears.contains(year)
                let vm = FilterCellViewModel(title: year, isChecked: isChecked)
                self.yearCellVMs?.append(vm)
            }
        }
    }
    
    fileprivate func buildSortFilterCVMs() {
        let sorts: [FilterModel.SortType] = [.none, .ascending, .descending]
        self.sortCellVMs = [FilterCellViewModel]()
        for sort in sorts {
            let isChecked = manager.filteredModel.sortType == sort
            let vm = FilterCellViewModel(title: sort.text, isChecked: isChecked)
            self.sortCellVMs?.append(vm)
        }
    }
}


// MARK: - CollectionControl
extension FilterViewModel {
    
    var numberOfSections: Int {
        if let _ = yearCellVMs,
            let _ = sortCellVMs {
            return 2
        }
        return 1
    }
    
    func isSortViewModel(indexPath: IndexPath) -> Bool {
        if numberOfSections == 2 {
            switch indexPath.section {
            case 0:
                return false
            default:
                return true
            }
        }
        return true
    }
    
    func numberOfCells(section: Int) -> Int {
        if isSortViewModel(indexPath: IndexPath(row: 0, section: section)) {
            return 3
        }
        return yearCellVMs?.count ?? 0
    }
    
    func cellViewModel(indexPath: IndexPath) -> FilterCellViewModel? {
        if isSortViewModel(indexPath: indexPath) {
            return sortCellVMs?[indexPath.row]
        }
        return yearCellVMs?[indexPath.row]
    }
    
    func didSelectedCell(indexPath: IndexPath) {
        guard let vm = cellViewModel(indexPath: indexPath) else {
            return
        }
        
        if isSortViewModel(indexPath: indexPath) {
            if vm.isChecked {
                return
            }
            let sorts: [FilterModel.SortType] = [.none, .ascending, .descending]
            for sort in sorts {
                if sort.text == vm.title {
                    manager.filteredModel.sortType = sort
                    buildSortFilterCVMs()
                    return
                }
            }
        }
        vm.isChecked = !vm.isChecked
        if vm.isChecked {
            if manager.filteredModel.years.contains(vm.title) {
                return
            }
            manager.filteredModel.years.append(vm.title)
//            buildYearsFilterCVMs()
            return
        }
        
        if let index = manager.filteredModel.years.index(of: vm.title) {
            manager.filteredModel.years.remove(at: index)
            return
        }
    }
}
