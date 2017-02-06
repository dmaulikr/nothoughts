//
//  MeditationPageViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/30/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

class MeditationPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, MeditationDelegate {
    
    var pages: [UIViewController] = []
    var pageIndex = 0
        
    // Page Before
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
                
        let index = (self.pages as NSArray).index(of: viewController)
        
        // if currently displaying first view controller, return nil to indicate that there is no previous view controller
        return (index == 0 ? nil : self.pages[index - 1])
    }
    
    
    // Page After
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let index = (self.pages as NSArray).index(of: viewController)
        
        // if currently displaying last view controller, return nil to indicate that there is no next view controller
        return (index == self.pages.count - 1 ? nil : self.pages[index + 1])
    }
    
    
    
    func presentPageViewController() {
        
        self.pages = [
            self.storyboard!.instantiateViewController(withIdentifier: "MeditationBeginViewController") as! MeditationBeginViewController,
            self.storyboard!.instantiateViewController(withIdentifier: "MeditationSettingsViewController") as! MeditationSettingsViewController
        ]
        
        let startingViewController = self.pages.first!
        setViewControllers([startingViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }
    
    func nextPagePressed() {
        setViewControllers([self.pages.last!], direction: .forward, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        self.delegate = self
        self.presentPageViewController()
        (self.pages.first as! MeditationBeginViewController).meditationDelegate = self
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
