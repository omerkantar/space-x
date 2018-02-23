//
//  LinksModel.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit
import ObjectMapper


class LinksModel: Mappable {

    var missionPatch: String?
    var redditCampaign: String?
    var redditLaunch: String?
    var redditMedia: String?
    var videoLink: String?
    var articleLink: String?
    var presskit: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        missionPatch <- map["mission_patch"]
        redditCampaign <- map["reddit_campaign"]
        redditLaunch <- map["reddit_launch"]
        redditMedia <- map["reddit_media"]
        videoLink <- map["video_link"]
        articleLink <- map["article_link"]
        presskit <- map["presskit"]
        
    }
}
