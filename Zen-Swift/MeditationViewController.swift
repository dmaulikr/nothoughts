//
//  MeditationViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/2/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit
import AudioKit

class MeditationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("View did load")
        // Do any additional setup after loading the view.
        let oscillator = AKOscillator()
        let envelope = AKAmplitudeEnvelope(oscillator)
        oscillator.amplitude = 0.7
        oscillator.frequency = 440.0
        envelope.attackDuration = 0.1
        envelope.decayDuration = 0.1
        envelope.sustainLevel = oscillator.amplitude
        envelope.releaseDuration = 0.6
        
        AudioKit.output = envelope
        AudioKit.start()
        oscillator.start()
        envelope.start()
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (timer) in envelope.stop()})
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
