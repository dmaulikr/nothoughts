//
//  LessonPageViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/30/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

class LessonPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, ControllerDelegate {
    
    let fileNames = ["right-view", "right-thinking", "right-mindfulness", "right-speech", "right-action", "right-diligence", "right-concentration", "right-livelihood"]
    
    var lessonArray: Array <String>!
    var pageIndex = 0
    
    var dharmaIndex: Int = 0
    
    // Controller Delegate
    
    func parentToChild(newIndex: Int) {
        dharmaIndex = newIndex
        pageIndex = 0
        setNewLessonArray()
    }
    
    // Page View methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let contentVC = viewController as! LessonContentViewController
        let currentIndex = contentVC.pageIndex
        let previousIndex = currentIndex - 1
        
        if currentIndex == NSNotFound || currentIndex == 0 {
            return nil
        }
        
        return viewControllerAtIndex(index: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let contentVC = viewController as! LessonContentViewController
        let currentIndex = contentVC.pageIndex
        let nextIndex = currentIndex + 1
        
        
        if currentIndex == NSNotFound || currentIndex == lessonArray.count - 1 {
            return nil
        }
        
        return viewControllerAtIndex(index: nextIndex)
    }
    
    func viewControllerAtIndex(index: NSInteger) -> LessonContentViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Create a new view controller and pass suitable data.
        let contentViewController = storyboard.instantiateViewController(withIdentifier: "LessonContentViewController") as! LessonContentViewController
        
        contentViewController.lessonContent = lessonArray[index]
        contentViewController.pageIndex = index
        pageIndex = index
        
        UIView.animate(withDuration: 0.5, animations: { self.view.alpha = 1 })
        
        return contentViewController
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return lessonArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pageIndex
    }
    // Private methods 
    
    func setNewLessonArray() {
        lessonArray = nil
        let path = Bundle.main.path(forResource: fileNames[dharmaIndex], ofType: ".txt")
        var fileContent: String!
        
        do {
            fileContent = try String.init(contentsOfFile: path!)
        } catch {
            print("Could not read file")
        }
        
        lessonArray = fileContent.components(separatedBy: "~")
        
        
        UIView.animate(withDuration: 0.5, animations: { self.view.alpha = 0} , completion: {Bool in
        
            self.setViewControllers([self.viewControllerAtIndex(index: 0)], direction: .forward, animated: false, completion: nil)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        self.setNewLessonArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "LessonChildSegue" {
         
        }
    }


}
