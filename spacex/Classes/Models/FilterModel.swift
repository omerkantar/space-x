//
//  FilterModel.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

class FilterModel: NSObject {
    var sortType: SortType = .none
    var selectedYears: [String]?
    
    func remove() {
        sortType = .none
        selectedYears = [String]()
    }
}


enum SortType {
    case none
    case ascending
    case descending
}
