//
//  InitialViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/2/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit


class InitialViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
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
            let mvc = segue.destination as! MeditationViewController
            
            if (textField.text != nil) {
                mvc.meditationTime = Double(textField.text!)!

            }
        }
    }


}

