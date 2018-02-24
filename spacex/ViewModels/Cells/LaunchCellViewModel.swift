//
//  LaunchCellViewModel.swift
//  spacex
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

class LaunchCellViewModel: BaseCellViewModel {

    var dateText: String?
    var rocketName: String?
    var imageURL: URL?
    
    override init() {
        let width: Int = 320 + Int(arc4random()%320)
        let height: Int = 200 + Int(arc4random()%320)

        self.dateText = "30.02.2013"
        self.rocketName = "Falcon 9"
        self.imageURL = "https://loremflickr.com/\(width)/\(height)".url
    }
    
    init(launch: LaunchModel) {
        self.dateText = launch.dateUtc?.utcDate?.string
        self.rocketName = launch.rocketModel?.name
        self.imageURL = launch.linksModel?.missionPatch?.url
    }
}
