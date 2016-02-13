//
//  ViewController.swift
//  ObjcSwiftTogether
//
//  Created by J Nastos on 12/16/15.
//  Copyright © 2015 J Nastos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let a = MyDataModel()
        a.stringProperty = "String data"
        a.intProperty = 45
        print("Result: \(a.intPropertySquared())")
        a.printMyStringProperty()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

