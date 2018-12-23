//
//  TutorialViewController.swift
//  KasperCatch
//
//  Created by Jackeline Lee on 11/7/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    var pageBoard = UIStoryboard(name: "Main", bundle: nil)
    lazy var pages: [UIViewController] = { return [ pageBoard.instantiateViewController(withIdentifier: "page1"),pageBoard.instantiateViewController(withIdentifier: "page2"),pageBoard.instantiateViewController(withIdentifier: "page3"),pageBoard.instantiateViewController(withIdentifier: "page4"),pageBoard.instantiateViewController(withIdentifier: "page5"),pageBoard.instantiateViewController(withIdentifier: "page6"),pageBoard.instantiateViewController(withIdentifier: "page7"),pageBoard.instantiateViewController(withIdentifier: "page8"),pageBoard.instantiateViewController(withIdentifier: "page9"), ]
    }()
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let page1 = pages.first{ setViewControllers([page1], direction: .forward, animated: true, completion: nil)}
        configurePage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configurePage(){
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        self.view.addSubview(pageControl)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentPage = pages.index(of: viewController)
        let previousPage = currentPage! - 1
        if previousPage < 0 {
            return nil
        }
        return pages[previousPage]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentPage = pages.index(of: viewController)
        let nextPage = currentPage! + 1
        if nextPage == pages.count {
            return nil
        }
        return pages[nextPage]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentView = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.index(of: currentView)!
    }
}
