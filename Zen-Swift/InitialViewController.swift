//
//  InitialViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/2/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit


class InitialViewController: UIViewController  {
    
    let pathArray = ["Right View", "Right Thinking", "Right Mindfulness", "Right Speech", "Right Action", "Right Diligence", "Right Concentration", "Right Livelihood"]
    
    @IBOutlet weak var lessonLabel: UILabel!
    @IBOutlet var swipeGestureRecognizer: UISwipeGestureRecognizer!
    
    @IBAction func swipe(_ sender: Any) {
        
        if swipeGestureRecognizer.direction == .left {
            
            print("Left")
            
        }
        
    }
    
    @IBAction func beginPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "MeditationSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MeditationSegue" {
//            let mvc = segue.destination as! MeditationViewController
            
            
        }
    }
}
