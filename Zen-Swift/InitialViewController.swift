//
//  InitialViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/2/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBAction func beginPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "LessonSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        let gradient: CAGradientLayer = CAGradientLayer()
        
        let topColor = UIColor(red: 187/255, green: 217/255, blue: 220/255, alpha: 1.0)
        let bottomColor = UIColor(red: 70/255, green: 217/255, blue: 212/255, alpha: 1.0)
        
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
        
        if segue.identifier == "LessonSegue" {
//            let lvc = segue.destination as! LessonViewController
//            lvc.lessonTitle = pathArray[pageIndex]
        }
    }
}
