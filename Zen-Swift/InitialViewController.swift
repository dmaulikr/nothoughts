//
//  InitialViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/2/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit


@objc
protocol ControllerDelegate {
    
    func parentToChild(newIndex: Int)
}

class InitialViewController: UIViewController, DharmaDelegate {
    
    var didDelegate: ControllerDelegate?
    var willDelegate: ControllerDelegate?
    
    var index: Int = 0 {
        didSet {
            print("ivc " + String(index))
            
            if willDelegate != nil {
                willDelegate?.parentToChild(newIndex: index)
            }
        }
    }
        
    func newLesson(lessonIndex: Int) {
        index = lessonIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            
        let gradient: CAGradientLayer = CAGradientLayer()
        
        let topColor = UIColor(red: 164/255, green: 190/255, blue: 250/255, alpha: 1.0)
        let bottomColor = UIColor(red: 131/255, green: 163/255, blue: 195/255, alpha: 1.0)
        
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.view.frame
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        var meditationTime = UserDefaults.standard.double(forKey: "meditation-time")
        
        if meditationTime == 0.0 {
            meditationTime = 10 * 60
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DharmaChildSegue" {
            
            let dpvc = segue.destination as! DharmaPageViewController
            dpvc.dharmaDelegate = self
        }
    
        if segue.identifier == "LessonChildSegue" {
            
            let lpvc = segue.destination as! LessonPageViewController
            lpvc.dharmaIndex = index
            self.willDelegate = lpvc
        }
    }
}
