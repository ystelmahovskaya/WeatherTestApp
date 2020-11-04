//
//  CarouselViewController.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-01.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation
import UIKit


class PagesViewController : UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    

    var pages = [UIViewController]()
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = self.pages.count
        control.currentPage = 0
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
        
    }
    
    private func setupConstraints(){
        self.view.addSubview(self.pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20),
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
    
    
    
}
