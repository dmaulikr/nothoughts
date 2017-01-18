//
//  InitialViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/2/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit


class InitialViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageIndex: Int = 0
    var pageViewController: UIPageViewController?
    let pathArray = ["Right View", "Right Thinking", "Right Mindfulness", "Right Speech", "Right Action", "Right Diligence", "Right Concentration", "Right Livelihood"]
    
    @IBAction func beginPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "MeditationSegue", sender: self)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
//        let pageContent: PageContentViewController = viewController as! PageContentViewController
        
        let pageContentVC = viewController as! PageContentViewController
        let currentIndex = pageContentVC.index
        var previousIndex = abs((currentIndex! - 1) % pathArray.count)
        
        if pageIndex == NSNotFound {
            return nil
        }
        
        if currentIndex == 0 {
            previousIndex = pathArray.count - 1
        }
        
        return viewControllerAtIndex(index: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let pageContentVC = viewController as! PageContentViewController
        let currentIndex = pageContentVC.index
        let nextIndex = abs((currentIndex! + 1) % pathArray.count)

        if (pageIndex == NSNotFound) {
            return nil;
        }
        
        return viewControllerAtIndex(index: nextIndex)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pathArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func viewControllerAtIndex(index: NSInteger) -> PageContentViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Create a new view controller and pass suitable data.
        let contentViewController = storyboard.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
        
        contentViewController.lessonTitle = pathArray[index]
        contentViewController.index = index
        pageIndex = index
        
        return contentViewController
    }
    
    func presentPageController() {
        
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController!
        pageViewController?.dataSource = self
        
        let startingViewController = self.viewControllerAtIndex(index: 0)
        let viewControllers: [UIViewController] = [startingViewController]
        
        self.pageViewController?.setViewControllers(viewControllers, direction: .reverse, animated: true, completion: nil)
        
        // Change size
        self.pageViewController?.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 75)
        self.pageViewController?.view.center = self.view.center
        
        self.addChildViewController(pageViewController!)
        self.view.addSubview((pageViewController?.view)!)
        self.pageViewController?.didMove(toParentViewController: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        let topColor = UIColor(red: 187/255, green: 217/255, blue: 220/255, alpha: 1.0)
        let bottomColor = UIColor(red: 70/255, green: 217/255, blue: 212/255, alpha: 1.0)
        
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
//        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.view.frame
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        self.presentPageController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "LessonSegue" {
            let lvc = segue.destination as! LessonViewController
            lvc.lessonTitle = pathArray[pageIndex]
        }
    }
}
