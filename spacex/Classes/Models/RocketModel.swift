//
//  RocketModel.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit
import ObjectMapper

class RocketModel: Mappable {

    var id: String?
    var name: String?
    var type: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["rocket_id"]
        name <- map["rocket_name"]
        type <- map["rocket_type"]
    }
}
