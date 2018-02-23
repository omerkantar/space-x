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
