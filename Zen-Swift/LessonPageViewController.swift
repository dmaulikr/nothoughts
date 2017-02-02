//
//  LessonPageViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/30/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

class LessonPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, ControllerDelegate {
    
    var lessonTitle: String? {
        
        didSet {
            print("lpvc " + lessonTitle!)
        }
    }
    
    func changeLesson(lessonTitle: String) {
        self.lessonTitle = lessonTitle
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        return viewControllerAtIndex(index: 0)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return viewControllerAtIndex(index: 0)
    }
    
    func viewControllerAtIndex(index: NSInteger) -> LessonContentViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Create a new view controller and pass suitable data.
        let contentViewController = storyboard.instantiateViewController(withIdentifier: "LessonContentViewController") as! LessonContentViewController
        
        contentViewController.currentLesson = lessonTitle
        contentViewController.lessonContent = lessonTitle
        
        return contentViewController
    }
    
    func presentPageController() {
        
        setViewControllers([self.viewControllerAtIndex(index: 0)], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "LessonChildSegue" {
         
            let ivc = segue.destination as! InitialViewController
            ivc.controllerDelegate = self
        }
    }


}
