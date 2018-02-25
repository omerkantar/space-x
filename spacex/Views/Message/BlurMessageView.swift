//
//  BlurMessageView.swift
//  spacex
//
//  Created by omer kantar on 25.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

typealias BlurMessageTappedBlock = (_ title: String?) -> Void

class BlurMessageView: UIView {
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static var isShowing: Bool = false
    var duration: TimeInterval = 4.5
    var tappedBlock: BlurMessageTappedBlock?
    
    static func show(title: String, duration: TimeInterval = 3.5, tapped: BlurMessageTappedBlock? = nil) {
        if isShowing {
            return
        }
        isShowing = true
        let nibName = String(describing: BlurMessageView.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as! BlurMessageView
        view.titleLabel.text = title
        view.duration = duration
        view.build()
        view.tappedBlock = { (text) in
            if let tap = tapped {
                tap(text)
            }
        }
    }
}

fileprivate extension BlurMessageView {
    func build() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
        self.isUserInteractionEnabled = true
        self.titleLabel.isUserInteractionEnabled = true
        self.visualEffectView.isUserInteractionEnabled = true
        self.visualEffectView.layer.cornerRadius = 20.0
        self.visualEffectView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.groupTableViewBackground.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1.0
        
        self.addGestureRecognizer(tapGR)
        
        self.show()
    }
    
    // MARK: - Show Hide
    func show() {
        let screenSize = UIScreen.main.bounds.size
        self.alpha = 0.0
        self.frame.size.width = screenSize.width
        self.frame.origin = CGPoint(x: 0.0, y: screenSize.height - 100.0)
        let window = (UIApplication.shared.delegate as! AppDelegate).window
        window?.addSubview(self)
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
        UIView.animate(withDuration: 0.36, animations: {
            self.frame.origin.y = screenSize.height - 120.0
        }) { (fns) in
            Timer.scheduledTimer(timeInterval: self.duration, target: self, selector: #selector(self.hide), userInfo: nil, repeats: false)
        }
    }
    
    @objc func hide() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.2
            self.frame.origin.y = screenSize.height - 100.0
        }) { (fns) in
            BlurMessageView.isShowing = false
            self.removeFromSuperview()
        }
    }
    
    @objc func backgroundViewTapped() {
        if let block = tappedBlock, let title = titleLabel.text {
            block(title)
        }
        self.hide()
    }
}
