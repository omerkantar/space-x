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
    var years = [String]()
    var totalCount: Int = 0
    
    func remove() {
        sortType = .none
        years.removeAll()
    }
    
}

extension FilterModel {
    enum SortType {
        case none
        case ascending
        case descending
        
        var text: String {
            switch self {
            case .none:
                return "Any"
            case .ascending:
                return "Ascending"
            case .descending:
                return "Descending"
            }
        }
    }
}

