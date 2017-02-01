//
//  MeditationSettingsViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/30/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

class MeditationSettingsViewController: UIViewController {
    
    let index = 1
    
    @IBOutlet weak var timerController: SegmentedController!
    @IBOutlet weak var intervalController: SegmentedController!
    

    @IBAction func meditationTimerPressed(_ sender: Any) {
        self.setMeditationTime()
    }
    
    @IBAction func intervalTimerPressed(_ sender: Any) {
        self.setMeditationTime()
    }
    
    func setMeditationTime() {
        
        let meditationTime: Double
        let intervalTime: Double
        
        switch timerController.selectedIndex {
        case 0:
            meditationTime = 10 * 60
        case 1:
            meditationTime = 15 * 60
        case 2:
            meditationTime = 20 * 60
        case 3:
            meditationTime = 30 * 60
        case 4:
            meditationTime = 45 * 60
        case 5:
            meditationTime = 60 * 60
        default:
            meditationTime = 10 * 60
        }
        
        switch intervalController.selectedIndex {
        case 0:
            intervalTime = 0
        case 1:
            intervalTime = 5 * 60
        case 2:
            intervalTime = 10 * 60
        case 3:
            intervalTime = 15 * 60
        case 4:
            intervalTime = 22.5 * 60
        case 5:
            intervalTime = 30 * 60
        default:
            intervalTime = 0
        }
        
        UserDefaults.standard.set(meditationTime, forKey: "meditation-time")
        UserDefaults.standard.set(intervalTime, forKey: "interval-time")
        UserDefaults.standard.set(timerController.selectedIndex, forKey: "timer-index")
        UserDefaults.standard.set(intervalController.selectedIndex, forKey: "interval-index")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timerController.items = ["10", "15", "20", "30", "45", "60"]
        intervalController.items = ["None", "5", "10", "15","22.5", "30"]
        
        timerController.selectedIndex = UserDefaults.standard.integer(forKey: "timer-index")
        intervalController.selectedIndex = UserDefaults.standard.integer(forKey: "interval-index")
        
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
