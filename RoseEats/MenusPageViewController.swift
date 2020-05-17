//
//  FirstViewController.swift
//  RoseEats
//
//  Created by CSSE Department on 5/11/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit

class MenusPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: FigmaMenuPageContentViewController = viewController as! FigmaMenuPageContentViewController
        var index = pageContent.pageIndex
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        index! -= 1;
        return getViewControllerAtIndex(index: index!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: FigmaMenuPageContentViewController = viewController as! FigmaMenuPageContentViewController
        var index = pageContent.pageIndex
        if (index == NSNotFound)
        {
            return nil;
        }
        index! += 1;
        if (index == arrPageTitle.count)
        {
            return nil;
        }
        return getViewControllerAtIndex(index: index!)
    }
    

    var arrPageTitle: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = nil
        arrPageTitle = ["Beanies", "Chauncey's", "Moench Cafe", "Rose Garden"]
        self.dataSource = self
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)

    }
    
    
    func getViewControllerAtIndex(index: NSInteger) -> FigmaMenuPageContentViewController
    {
        // Create a new view controller and pass suitable data.
        //let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuPageContentViewController") as! MenuPageContentViewController
        //pageContentViewController.strTitle = "\(arrPageTitle[index])"
        //pageContentViewController.pageIndex = index
       // return pageContentViewController
        
        
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "FigmaMenuPageContentViewController") as! FigmaMenuPageContentViewController
        pageContentViewController.strTitle = "\(arrPageTitle[index])"
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }
}

