//
//  TitleHeaderView.swift
//  spacex
//
//  Created by omer kantar on 25.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

class TitleHeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    static func create(_ title: String? = nil) -> TitleHeaderView {
        let nibName = String(describing: TitleHeaderView.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as! TitleHeaderView
        view.titleLabel.text = title
        return view
    }
    
}
