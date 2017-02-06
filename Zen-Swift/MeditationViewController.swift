//
//  MeditationViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/18/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit
import AudioKit

class MeditationViewController: UIViewController {
    
    var meditationTime: Double = UserDefaults.standard.double(forKey: "meditation-time")
    let bellIntervals: Double = UserDefaults.standard.double(forKey: "interval-time")
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    var oscillator: AKOscillator!
    var filter: AKLowPassFilter!
    var envelope: AKAmplitudeEnvelope!
    var delay: AKDelay!
    var reverb: AKReverb!
    var processor: AKDynamicsProcessor!
    
    var countDownTime = 5
    
    var countDownTimer: Timer!
    var meditationTimer: Timer!
    var intervalTimer: Timer!
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBAction func endEarlyPressed(_ sender: Any) {
        
//        oscillator.stop()
//        delay.stop()
//        reverb.stop()
        
        if (countDownTimer != nil) {
            countDownTimer.invalidate()
        }
        
        if (meditationTimer != nil) {
            meditationTimer.invalidate()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func initializeBell() {
        
        // Init oscillator
        oscillator = AKOscillator()
        oscillator.stop()
        oscillator.amplitude = 2
        oscillator.frequency = random(440.0, 500.0)
        
        // Init filter
        filter = AKLowPassFilter(oscillator)
        filter.stop()
        filter.cutoffFrequency = 8500
        
        // Init envelope
        envelope = AKAmplitudeEnvelope(filter)
        envelope.stop()
        envelope.attackDuration = 0.03
        envelope.decayDuration = 0.1
        envelope.sustainLevel = 2.0
        envelope.releaseDuration = random(0.8, 1)
        
        // Init delay for chorusing
        delay = AKDelay(envelope)
        delay.stop()
        delay.time = random(0.01, 0.8)
        delay.dryWetMix = 1.0
        delay.feedback = 0.3
        
        // Init reverb
        reverb = AKReverb(delay)
        reverb.stop()
        reverb.dryWetMix = random(0.7, 0.9)
        reverb.loadFactoryPreset(AVAudioUnitReverbPreset.cathedral)
        
        // Init dynamic
        processor = AKDynamicsProcessor(reverb)
        processor.stop()
        processor.headRoom = 0.1
        processor.masterGain = 40
        
        // Start audio
        AudioKit.stop()
        AudioKit.output = reverb
        AudioKit.start()
        oscillator.start()
        envelope.start()
        delay.start()
        reverb.start()
        processor.start()
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: {(timer) in self.envelope.stop()})
    }
    
    func warmUpCountDown() {
        
        countDownLabel.text = String(countDownTime)
        
        
        self.countDownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            
            self.countDownTime -= 1
            self.countDownLabel.text = String(self.countDownTime)
            
            if self.countDownTime < 0 {
                
                self.countDownTimer.invalidate()
                self.countDownLabel.isHidden = true
                
                self.meditation()
            }
        })
        
    }

    func meditation() {
        
        self.initializeBell()
        UIApplication.shared.isIdleTimerDisabled = true
        
        print(meditationTime)
        print(bellIntervals)
        
        if bellIntervals > 0 {
            
            let numberOfBells = Int(meditationTime / bellIntervals)
            var bellNumber = 0
            
            // Interval bells timer
            self.intervalTimer = Timer.scheduledTimer(withTimeInterval: bellIntervals, repeats: true, block: { (timer) in
                
                self.initializeBell()
                bellNumber += 1
                
                if bellNumber == numberOfBells {
                    
                    self.intervalTimer.invalidate()
                    
                }
            })
        }

        
        //Init timer
        self.meditationTimer = Timer.scheduledTimer(withTimeInterval: meditationTime, repeats: false, block: { (timer) in
            self.endMeditation()
        })
        
    }
    
    func endMeditation() {
        
        self.initializeBell()
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let gradient: CAGradientLayer = CAGradientLayer()
        
        let topColor = UIColor(red: 187/255, green: 217/255, blue: 220/255, alpha: 1.0)
        let bottomColor = UIColor(red: 70/255, green: 217/255, blue: 212/255, alpha: 1.0)
        
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = self.view.frame
        self.view.layer.insertSublayer(gradient, at: 0)
        
        AKSettings.playbackWhileMuted = true
        warmUpCountDown()
    
//        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { (timer) in self.meditation()})
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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
