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
    
    var index: Int = 0 {
        
        didSet {
            print("lpvc " + String(index))
            
            // Change lesson Array
            
            
            // Set VCs
        }
    }
    
    // Controller Delegate
    
    func parentToChild(newIndex: Int) {
        index = newIndex
    }
    
    // Page View methods
    
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
        
        return contentViewController
    }
    
    func presentPageController() {
        
        setViewControllers([self.viewControllerAtIndex(index: 0)], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }
    
    // Private methods 
    
    func setNewLessonArray() {
        lessonArray = nil
        let path = Bundle.main.path(forResource: fileNames[index], ofType: ".txt")
        var fileContent: String!
        
        
        do {
            fileContent = try String.init(contentsOfFile: path!)
        } catch {
            print("Could not read file")
        }
        
        lessonArray = fileContent.components(separatedBy: "\n")
        
        print(lessonArray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
