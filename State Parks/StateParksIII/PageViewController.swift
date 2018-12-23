//
//  PageViewController.swift
//  State Parks
//
//  Created by Jackeline Lee on 10/8/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    var pageBoard = UIStoryboard(name: "StateParks3", bundle: nil)
    lazy var pages: [UIViewController] = { return [ pageBoard.instantiateViewController(withIdentifier: "firstPage"), pageBoard.instantiateViewController(withIdentifier: "secondPage"), pageBoard.instantiateViewController(withIdentifier: "thirdPage") ]
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
