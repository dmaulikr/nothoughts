//
//  DharmaPageViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/28/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

protocol DharmaDelegate {
    func newLesson(lessonIndex: Int)
}

class DharmaPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var dharmaDelegate: DharmaDelegate?
    
    var pageIndex: Int = 0
    let pathArray = ["Right View", "Right Thinking", "Right Mindfulness", "Right Speech", "Right Action", "Right Diligence", "Right Concentration", "Right Livelihood"]
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let pageContentVC = viewController as! DharmaTitleViewController
        let currentIndex = pageContentVC.index
        var previousIndex = abs((currentIndex - 1) % pathArray.count)
        
        if pageIndex == NSNotFound {
            return nil
        }
        
        if currentIndex == 0 {
            previousIndex = pathArray.count - 1
        }
        
        return viewControllerAtIndex(index: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let pageContentVC = viewController as! DharmaTitleViewController
        let currentIndex = pageContentVC.index
        let nextIndex = abs((currentIndex + 1) % pathArray.count)
        
        if (pageIndex == NSNotFound) {
            return nil;
        }
        
        return viewControllerAtIndex(index: nextIndex)
    }
    
    func viewControllerAtIndex(index: NSInteger) -> DharmaTitleViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Create a new view controller and pass suitable data.
        let contentViewController = storyboard.instantiateViewController(withIdentifier: "DharmaTitleViewController") as! DharmaTitleViewController
        
        contentViewController.lessonTitle = pathArray[index]
        contentViewController.index = index
        pageIndex = index
        
        return contentViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed == true {
            if dharmaDelegate != nil {
                dharmaDelegate?.newLesson(lessonIndex: pageIndex)
            }
        }
        
    }

    func presentPageController() {
        
        setViewControllers([self.viewControllerAtIndex(index: 0)], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        pageIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.dataSource = self
        self.delegate = self
        self.presentPageController()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
