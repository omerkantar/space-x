//
//  RequestTarget.swift
//  spacex
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit
import Moya

fileprivate let kSpaceXAPI = "https://api.spacexdata.com/v2"
enum RequestTarget {
    case coffee // ☕️
    case launches
}




extension RequestTarget: TargetType {
    var baseURL: URL {
        if let url = URL(string: kSpaceXAPI) {
            return url
        }
        return URL(string: "www.apple.com")!
    }
    
    var path: String {
        switch self {
        case .launches:
            return "/launches"
        default:
            break
        }
        return ""
    }
    
    var method: Moya.Method {
        return Method.get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}

