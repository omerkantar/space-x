//
//  LaunchListViewModel.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit
import ObjectMapper

class LaunchListViewModel {

    var allLaunchs: [LaunchModel]?
    var filteredCellVMs: [LaunchCellViewModel]?
    let filterManager = FilterManager.sharedInstance
    
    func build(responseModel: ResponseModel) {
        if let list = Mapper<LaunchModel>().mapArray(JSONObject: responseModel.data) {
            self.allLaunchs = list
            filterManager.loaded(launchs: list)
            filteredCellVMs = [LaunchCellViewModel]()
            for item in list {
                filteredCellVMs?.append(LaunchCellViewModel(launch: item))
            }
        }
    }
}
