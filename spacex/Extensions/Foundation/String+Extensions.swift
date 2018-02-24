//
//  String+Extensions.swift
//  spacex
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import Foundation

// MARK: - URL
extension String {
    var url: URL? {
        return URL(string: self)
    }
}


//"launch_date_utc":"2006-03-24T22:30:00Z",
//"launch_date_local":"2006-03-25T10:30:00+12:00",

// MARK: - Date
extension String {
    var utcDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter.date(from: self)
    }
    
    var localDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
}
