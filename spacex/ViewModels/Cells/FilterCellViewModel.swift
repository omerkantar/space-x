//
//  FilterCellViewModel.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

class FilterCellViewModel: BaseCellViewModel {

    var title: String
    var isChecked: Bool = false
    init(title: String, isChecked: Bool) {
        self.title = title
        self.isChecked = isChecked
    }
    
}
