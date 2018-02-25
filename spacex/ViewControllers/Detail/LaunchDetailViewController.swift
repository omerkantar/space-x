//
//  LaunchDetailViewController.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

class LaunchDetailViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    var pageController: UIPageViewController?
    var currentIndex: Int = 0
    var launchs: [LaunchModel]?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }

    // MARK: - Build
    func build() {
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController?.dataSource = self
        pageController?.delegate = self
        pageController?.automaticallyAdjustsScrollViewInsets = false

        guard let pageController = pageController else {
            return
        }
        
        self.containerView.addSubview(pageController.view)
        self.addChildViewController(pageController)

        if let vc = tableViewController(index: currentIndex) {
            pageController.setViewControllers([vc],
                               direction: .forward,
                               animated: false,
                               completion: nil)
        }
        
        DispatchQueue.main.async {
            pageController.view.frame = CGRect(origin: CGPoint.zero, size: self.containerView.frame.size)
        }
    }
    
    func tableViewController(index: Int) -> LaunchDetailTableViewController? {
        guard let launch = launchs?[index] else {
            return nil
        }
        let vc = LaunchDetailTableViewController()
        vc.launch = launch
        return vc
    }
    
    // MARK: - Action
    @IBAction func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension LaunchDetailViewController: UIPageViewControllerDataSource {
    func nextViewController(_ viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        
        guard let vc = viewController as? LaunchDetailTableViewController, let launch = vc.launch else {
            return nil
        }
        
        guard var index = launchs?.index(where: { $0.flightNumber == launch.flightNumber })  else {
            return nil
        }
        
        if isAfter {
            index += 1
        } else {
            index -= 1
        }
        
        if let vc = tableViewController(index: index) {
            currentIndex = index
            return vc
        }
        return nil
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: false)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: true)
    }
}

// MARK: - UITableViewDelegate
extension LaunchDetailViewController: UIPageViewControllerDelegate {
    
}
