//
//  LaunchVideoHeaderView.swift
//  spacex
//
//  Created by omer kantar on 25.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit
import WebKit

class LaunchVideoHeaderView: UIView {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    static func create(videoURL: URL) -> LaunchVideoHeaderView {
        let nibName = String(describing: LaunchVideoHeaderView.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as! LaunchVideoHeaderView
        view.build(videoURL: videoURL)
        return view
    }
}

// MARK: - Build
fileprivate extension LaunchVideoHeaderView {
    func build(videoURL: URL) {
        webView.delegate = self
        webView.loadRequest(URLRequest(url: videoURL))
        webView.allowsInlineMediaPlayback = true
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.alwaysBounceHorizontal = false
        webView.scrollView.alwaysBounceVertical = false
    }
    
    func html(url: URL) -> String {
        return "<iframe width=\"\(self.bounds.width)\" height=\"\(self.bounds.height)\" src=\"\(url.absoluteString)\" frameborder=\"0\" allowfullscreen></iframe>"
    }
    
    
}

// MARK: - UIWebViewDelegate
extension LaunchVideoHeaderView: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
}
