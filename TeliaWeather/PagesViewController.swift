//
//  CarouselViewController.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-01.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation
import UIKit

/**
   Holder for pages
   */
class PagesViewController : UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    

    var pages = [UIViewController]()
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = self.pages.count
        control.currentPage = 0
        control.currentPageIndicatorTintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        control.pageIndicatorTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    override func viewDidLoad() {
        self.dataSource = self
        self.delegate = self
        
        let page1 = WeatherPage(cityName: "Gothenburg")
        let page2 = WeatherPage(cityName: "Malmo")
        let page3 = WeatherPage(cityName: "Stockholm")
        self.pages.append(page1)
        self.pages.append(page2)
        self.pages.append(page3)
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        setupConstraints()
    }
    
    private func setupConstraints(){
        self.view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5),
            pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
        ])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                return self.pages.last
            } else {
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                return self.pages[viewControllerIndex + 1]
            } else {
                return self.pages.first
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
    
    
}
