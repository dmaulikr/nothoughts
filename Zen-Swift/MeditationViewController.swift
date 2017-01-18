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
    
    var meditationTime: Double!
    var bellIntervals: Double!
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    var oscillator: AKOscillator!
    var filter: AKLowPassFilter!
    var envelope: AKAmplitudeEnvelope!
    var delay: AKDelay!
    var reverb: AKReverb!
    var processor: AKDynamicsProcessor!
    
    @IBAction func endEarlyPressed(_ sender: Any) {
        
//        oscillator.stop()
//        delay.stop()
//        reverb.stop()
        self.dismiss(animated: true, completion: nil)
    }
    
    func initializeBell() {
        
        // Init oscillator
        oscillator = AKOscillator()
        oscillator.stop()
        oscillator.amplitude = 0.95
        oscillator.frequency = random(300.0, 500.0)
        
        // Init filter
        filter = AKLowPassFilter(oscillator)
        filter.stop()
        filter.cutoffFrequency = 1000
        
        // Init envelope
        envelope = AKAmplitudeEnvelope(filter)
        envelope.stop()
        envelope.attackDuration = 0.05
        envelope.decayDuration = 0.1
        envelope.sustainLevel = 1.0
        envelope.releaseDuration = random(0.5, 0.8)
        
        // Init delay for chorusing
        delay = AKDelay(envelope)
        delay.stop()
        delay.time = random(0.01, 0.05)
        delay.dryWetMix = 1.0
        delay.feedback = 0.3
        
        // Init reverb
        reverb = AKReverb(delay)
        reverb.stop()
        reverb.dryWetMix = random(0.4, 0.7)
        reverb.loadFactoryPreset(AVAudioUnitReverbPreset.cathedral)
        
        // Init dynamic
        processor = AKDynamicsProcessor(reverb)
        processor.stop()
        processor.headRoom = 0.5
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

    func meditation() {
        
        self.initializeBell()
        UIApplication.shared.isIdleTimerDisabled = true
        
        //Init timer
        Timer.scheduledTimer(withTimeInterval: meditationTime, repeats: false, block: { (timer) in self.endMeditation()})
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
        
//        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { (timer) in self.meditation()})
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
