//
//  PageContentViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/14/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

class DharmaTitleViewController: UIViewController {
    
    var lessonTitle = String()
    var index = Int()
    
    @IBOutlet weak var lessonLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lessonLabel.text = lessonTitle
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
