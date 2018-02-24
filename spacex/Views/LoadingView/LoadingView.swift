//
//  LoadingView.swift
//  spacex
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Show and hide
    static func show(title: String? = nil, parentView: UIView) -> LoadingView {
        let nibName = String(describing: LoadingView.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as! LoadingView
        view.build(title: title, parentView: parentView)
        return view
    }
    
    static func hide(parentView: UIView) {
        // parent viewin subviewste loading view arayip onu hide edecegiz. For dongusundense Lazy array memory performansini baya artiracagindan onu kullandim!
        let views = parentView.subviews.lazy.filter { (view) -> Bool in
            return view is LoadingView || view.isKind(of: LoadingView.self)
        }
        // varsa 1 tane vardir zaten.
        guard let first = views.first as? LoadingView else {
            return
        }
        first.hide()
    }
    
    func hide() {
        self.removeFromSuperview()
    }
}

// MARK: - Build
fileprivate extension LoadingView {
    func build(title: String?, parentView: UIView) {
        self.titleLabel.text = title ?? "Loading..."
        self.activityIndicatorView.startAnimating()
        parentView.addSubview(self)
        self.center = parentView.center
        self.center.y = 200.0
    }
}
