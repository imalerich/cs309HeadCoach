//
//  SecondViewController.swift
//  StoryboardsProject
//
//  Created by Joseph Young on 2/13/16.
//  Copyright © 2016 Joseph Young. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController : UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    
    @IBAction func buttonPressed(sender : UIButton){
        myLabel.text = "Pressed"
        myButton.setTitle("Done", forState: .Normal)
    }
}