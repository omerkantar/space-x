//
//  ServiceManager.swift
//  spacex
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper

// MARK: - Bu manager ile network layeri manage edebilecegiz.

typealias NetworkSuccessBlock = (_ responseModel: ResponseModel) -> Void
typealias NetworkFailureBlock = (_ error: Error?, _ responseModel: ResponseModel?) -> Void

class ServiceManager {

    func request(target: RequestTarget, success: NetworkSuccessBlock? = nil, failure: NetworkFailureBlock? = nil) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let provider = MoyaProvider<RequestTarget>()
        
        provider.request(target) { (result) in
            
            switch result {
            case .success(let moyaResponse):
                let statusCode = moyaResponse.statusCode
                do {
                    try moyaResponse.filterSuccessfulStatusCodes()
                    let data = try moyaResponse.mapJSON()
                    if let response = Mapper<ResponseModel>().map(JSONObject: data) {
                        if let block = success {
                            block(response)
                        }
                    } else {
                        if let block = failure {
                            block(nil, ResponseModel.error(type: .mapping))
                        }
                    }
                } catch let error {
                    print("Service Error:", error)
                    // show an error to your user
                    
                    if let error = error as? MoyaError {
                        do {
                            let body = try error.response?.mapJSON()
                            print(body)
                        } catch let err {
                            print(err)
                        }
                    }
                    
                    if let type = ResponseModel.ErrorType(rawValue: statusCode) {
                        if let block = failure {
                            block(nil, ResponseModel.error(type: type))
                        }
                    } else {
                        if let block = failure {
                            block(nil, ResponseModel.error(type: .mapping))
                        }
                    }
                }
                break
            case .failure(let error):
                
                if let block = failure {
                    block(error, nil)
                }
                break
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

    }
}
