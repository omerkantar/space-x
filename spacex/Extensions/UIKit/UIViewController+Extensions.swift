//
//  UIViewController.swift
//  spacex
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit


// MARK: - Network
extension UIViewController {
    
    func request(target: RequestTarget, loadingTitle: String? = nil,  loadingParentView: UIView? = nil, success: NetworkSuccessBlock?, failure: NetworkFailureBlock?) {
        
        if let loadingParentView = loadingParentView {
            
            let _ = LoadingView.show(title: loadingTitle, parentView: loadingParentView)
        }
        
        ServiceManager.request(target: target, success: { (model) in
            
            if let loadingParentView = loadingParentView {
                LoadingView.hide(parentView: loadingParentView)
            }
            
            if let success = success {
                success(model)
            }
            
        }, failure: failure)
    }
}