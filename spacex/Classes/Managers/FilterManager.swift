//
//  FilterManager.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

// MARK: - Singleton Class
// Singleton yaptim çünkü filtre yaptıktan sonra geri basınca filtrelecektir. Apple Alarm'daki deneyim gibi
// 
class FilterManager {
    
    static var sharedInstance: FilterManager = FilterManager()
    var model = FilterModel()
    var filteredModel = FilterModel()
    var numberOfYears: Int = 0
    
    func loaded(launchs: [LaunchModel]) {
        self.model.years = [String]()
        let allYears = launchs.lazy.map { (launch) -> String in
            if let year = launch.year {
                return year
            }
            return ""
        }
        for obj in allYears {
            if obj != "" &&
                !self.model.years.contains(obj) {
                self.model.years.append(obj)
            }
        }
        self.model.years.sort(by: <)
        numberOfYears = self.model.years.count
    }
    
    func filter(launchs: [LaunchModel]) -> [LaunchModel] {
        if isClearFilter() {
            return launchs
        }
        let years = filteredModel.years
        let sort = filteredModel.sortType
        var lazyLaunchs = launchs.lazy
        
        if years.count != 0 && years.count != numberOfYears {
            let filteredLaunchs = lazyLaunchs.filter({ (model) -> Bool in
                if let year = model.year {
                    return years.contains(year)
                }
                return false
            })
            lazyLaunchs = Array(filteredLaunchs).lazy
        }
        
        switch sort {
        case .ascending:
            let sorted = lazyLaunchs.sorted(by: { (first, second) -> Bool in
                if let year1 = first.year, let year2 = second.year {
                    return year1 < year2
                }
                return false
            })
            
            lazyLaunchs = sorted.lazy
            break
            
        case .descending:
            
            let sorted = lazyLaunchs.sorted(by: { (first, second) -> Bool in
                if let year1 = first.year, let year2 = second.year {
                    return year1 > year2
                }
                return false
            })
            
            lazyLaunchs = sorted.lazy

            break
        default:
            break
        }
        
        return Array(lazyLaunchs)
    }
    
    func isClearFilter() -> Bool {
        return (filteredModel.years.count == 0 || filteredModel.years.count == numberOfYears) && filteredModel.sortType == .none
    }
    
    
}
