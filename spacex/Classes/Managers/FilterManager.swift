//
//  FilterManager.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

// MARK: - Singleton Class
// Singleton yaptim çünkü filtre yaptıktan sonra geri basınca filtrelecektir. Apple Alarm'daki deneyim gibi
// 
class FilterManager {
    
    static var sharedInstance: FilterManager = FilterManager()
    var years: [String]?
    var model = FilterModel()

    func loaded(launchs: [LaunchModel]) {
        self.years = [String]()
        let allYears = launchs.lazy.map { (model) -> String in
            if let year = model.year {
                return year
            }
            return ""
        }
        for obj in allYears {
            if obj != "" &&
                !years!.contains(obj) {
                years?.append(obj)
            }
        }
        self.years?.sort(by: <)
    }

}
