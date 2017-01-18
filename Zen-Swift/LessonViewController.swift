//
//  LessonViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/2/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit
import AudioKit

class LessonViewController: UIViewController {
    
    // MARK: Properties
    var lessonTitle: String!
    
    var meditationDescription: String!
    
    var meditationTime: Double!
    var bellIntervals: Double!
    var timeElapsed: Int = Int()
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var timerController: SegmentedController!
    @IBOutlet weak var bellController: SegmentedController!
    @IBOutlet weak var dimmerController: SegmentedController!
    
    // MARK: IBActions
    
    @IBAction func meditatePressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "MeditationSegue", sender: self)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func timerControllerPressed(_ sender: Any) {
        
        setLabelText()
    }
    
    @IBAction func bellControllerPressed(_ sender: Any) {
        
        setLabelText()
    }
    
    // MARK: Private methods
    
    private func setLabelText() {
        
        switch timerController.selectedIndex {
        case 0:
            meditationTime = 60 * 10
        case 1:
            meditationTime = 60 * 15
        case 2:
            meditationTime = 60 * 20
        case 3:
            meditationTime = 60 * 30
        case 4:
            meditationTime = 60 * 45
        case 5:
            meditationTime = 60 * 60
        default:
            meditationTime = 60 * 10
        }
        
        switch bellController.selectedIndex {
        case 0:
            bellIntervals = 0
        case 1:
            bellIntervals = meditationTime / 2
        case 2:
            bellIntervals = meditationTime / 3
        case 3:
            bellIntervals = meditationTime / 4
        default:
            bellIntervals = 0
        }
        
        meditationDescription = "Meditate for " + String(Int(meditationTime / 60)) + " minutes with bells every " + String(Int(bellIntervals / 60)) + " minutes."
        
        settingsLabel.text = meditationDescription
    }
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        let topColor = UIColor(red: 187/255, green: 217/255, blue: 220/255, alpha: 1.0)
        let bottomColor = UIColor(red: 70/255, green: 217/255, blue: 212/255, alpha: 1.0)
        
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        //        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = self.view.frame
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timerController.items = ["10", "15", "20", "30", "45", "60"]
        bellController.items = ["None", "1/2", "1/3", "1/4"]
        dimmerController.items = ["Yes", "No"]
        
        meditationTime = 10 * 60
        bellIntervals = 0
        setLabelText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MeditationSegue" {
            let mvc = segue.destination as! MeditationViewController
            mvc.meditationTime = self.meditationTime
            mvc.bellIntervals = self.bellIntervals
            
        }
    }
    
}
