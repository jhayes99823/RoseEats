//
//  FirstViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/11/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit

class MenusPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let pageContentViewControllerIdentifier = "MenuPageContentViewController"
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.frame = CGRect.zero
        
        return pageControl
    }()
    
     override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
    
                    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        }
    
    
    
        required init?(coder: NSCoder) {
               super.init(coder: coder)
    
        }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = nil
       setUpUI()
        setupPageControl()
    }
    
    func setUpUI() {
        self.dataSource = self
        self.view.addSubview(pageControl)
        self.setViewControllers([viewControllerAtIndex(index: 0)] as? [UIViewController], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            var index = (viewController as! MenuPageContentViewController).pageIndex
            if(index == 0){
                return nil
            }
        index! -= 1
            return self.viewControllerAtIndex(index: index!)
        }
    
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            var index = (viewController as! MenuPageContentViewController).pageIndex
            index! += 1
            if(index! >= arrPageTitle.count){
                return nil
            }
            return self.viewControllerAtIndex(index: index!)
        }
    
        func viewControllerAtIndex(index : Int) -> UIViewController? {
            if((arrPageTitle.count == 0) || (index >= arrPageTitle.count)) {
                return nil
            }
            let storyboard=UIStoryboard(name: "Main", bundle: nil)
            let pageContentViewController = storyboard.instantiateViewController(withIdentifier: pageContentViewControllerIdentifier) as! MenuPageContentViewController
            pageContentViewController.strTitle = "\(arrPageTitle[index])"
            pageContentViewController.pageIndex = index
            return pageContentViewController
        }
    
        private func setupPageControl() {
            let appearance = UIPageControl.appearance()
            appearance.pageIndicatorTintColor = UIColor.gray
            appearance.currentPageIndicatorTintColor = UIColor.white
            appearance.backgroundColor = UIColor.clear
        }
    
        func presentationCount(for pageViewController: UIPageViewController) -> Int {
            return arrPageTitle.count
        }
    
        func presentationIndex(for pageViewController: UIPageViewController) -> Int {
            return 0
        }
    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        let pageContent: MenuPageContentViewController = viewController as! MenuPageContentViewController
//        var index = pageContent.pageIndex
//        if ((index == 0) || (index == NSNotFound))
//        {
//            return nil
//        }
//        index! -= 1;
//        return getViewControllerAtIndex(index: index!)
//    }
//
//
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        let pageContent: MenuPageContentViewController = viewController as! MenuPageContentViewController
//        var index = pageContent.pageIndex
//        if (index == NSNotFound)
//        {
//            return nil;
//        }
//        index! += 1;
//        if (index == arrPageTitle.count)
//        {
//            return nil;
//        }
//        return getViewControllerAtIndex(index: index!)
//    }
//
//    func getViewControllerAtIndex(index: NSInteger) -> MenuPageContentViewController
//    {
//        // Create a new view controller and pass suitable data.
//        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuPageContentViewController") as! MenuPageContentViewController
//        pageContentViewController.strTitle = "\(arrPageTitle[index])"
//        pageContentViewController.pageIndex = index
//        return pageContentViewController
//
//
//       let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "FigmaMenuPageContentViewController") as! FigmaMenuPageContentViewController
//       pageContentViewController.strTitle = "\(arrPageTitle[index])"
//       pageContentViewController.pageIndex = index
//        return pageContentViewController
//    }
//
//    private func setupPageControl() {
//        let appearance = UIPageControl.appearance()
//        appearance.pageIndicatorTintColor = UIColor.gray
//        appearance.currentPageIndicatorTintColor = UIColor.white
//        appearance.backgroundColor = UIColor.clear
//    }
//
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
//      {
//        return arrPageTitle.count
//      }
//
//      func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
//      {
//        return 0
//      }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for subView in self.view.subviews {
            if subView is UIScrollView {
            subView.frame = UIScreen.main.bounds
        } else if subView is UIPageControl {
            subView.backgroundColor = UIColor.clear
                self.view.bringSubviewToFront(subView)
        }
        }}
}

