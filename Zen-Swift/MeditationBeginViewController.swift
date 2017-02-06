//
//  MeditationBeginViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/30/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit
import AVFoundation

protocol MeditationDelegate {
    func nextPagePressed()
}

class MeditationBeginViewController: UIViewController {

    let index = 0
    let audioSession = AVAudioSession.sharedInstance()
    
    var meditationDelegate: MeditationDelegate?
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var volumePercentageLabel: UILabel!
    
    @IBAction func beginPressed(_ sender: Any) {
        let meditationVc = self.storyboard?.instantiateViewController(withIdentifier: "MeditationViewController") as! MeditationViewController
        
        meditationVc.modalTransitionStyle = .crossDissolve
        
        self.present(meditationVc, animated: true, completion: nil)
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        
        if meditationDelegate != nil {
            meditationDelegate?.nextPagePressed()
        }
    }
    
    func listenVolumeButton() {
        
        do {
            try audioSession.setActive(true)
        } catch {
            print("some error")
        }
        audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "outputVolume" {
            
            let volumePercentage = Int(audioSession.outputVolume * 100)
            volumePercentageLabel.text = "\(volumePercentage)%"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let meditationTime = Int(UserDefaults.standard.double(forKey: "meditation-time"))
        let intervalTime = Int(UserDefaults.standard.double(forKey: "interval-time"))
                
        if meditationTime > intervalTime && intervalTime != 0 {
            
            self.settingsButton.setTitle("\(meditationTime / 60) minutes with bells every \(intervalTime / 60) minutes",
                for: .normal)
            
        } else {
            
            self.settingsButton.setTitle("\(meditationTime / 60) minutes",
                for: .normal)
        }
        
        let volumePercentage = Int(audioSession.outputVolume * 100)
        volumePercentageLabel.text = "\(volumePercentage)%"
        listenVolumeButton()
        
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
