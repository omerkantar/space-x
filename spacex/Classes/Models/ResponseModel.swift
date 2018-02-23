//
//  ResponseModel.swift
//  spacex
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit
import ObjectMapper

// MARK: - Genel apilerde data, is success, message gelir ondan bunlari yazdim.
class ResponseModel: Mappable {

    var data: Any?
    var statusCode: Int = 200
    var isSuccess: Bool = false
    var object: Any?
    var message: String?
    
    init() { }
    
    required init?(map: Map) {
        self.object = map.currentValue
    }
    
    func mapping(map: Map) {
        data <- map["data"]
        isSuccess <- map["success"]
        message <- map["message"]
    }
    
    static func error(type: ResponseModel.ErrorType) -> ResponseModel {
        let model = ResponseModel()
        model.statusCode = type.rawValue
        model.message = type.message
        return model
    }
}

// MARK: - Response Error Type
extension ResponseModel {
    enum ErrorType: Int {
        case mapping = -1001
        case unauthorization = 401
        case notFound = 404
        case serverError = 500
        
        var message: String {
            switch self {
            case .mapping:
                return "Somethings went wrong 💥"
            case .notFound:
                return "Not found data 📭"
            case .unauthorization:
                return "Unauthorization user 🚨"
            case .serverError:
                return "Server Failure 🔥"
            }
            return ""
        }
    }
}

