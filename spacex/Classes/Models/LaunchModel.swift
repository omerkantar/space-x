//
//  LaunchModel.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit
import ObjectMapper

class LaunchModel: Mappable {

    var year: String?
    var dateUnix: TimeInterval = 0.0
    var dateUtc: String?
    var dateLocal: String?
    var detail: String?
    var rocketModel: RocketModel?
    var linksModel: LinksModel?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        year <- map["launch_year"]
        dateUnix <- map["launch_date_unix"]
        dateUtc <- map["launch_date_utc"]
        dateLocal <- map["launch_date_local"]
        detail <- map["details"]
        rocketModel <- map["rocket"]
        linksModel <- map["links"]
    }
}
