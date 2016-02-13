//
//  SecondViewController.swift
//  StoryboardsProject
//
//  Created by J Nastos on 12/11/15.
//  Copyright © 2015 J Nastos. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController : UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    
    @IBAction func buttonPressed(sender : UIButton) {
        myLabel.text = "Pressed"
        myButton.setTitle("Done", forState: .Normal)
    }
}