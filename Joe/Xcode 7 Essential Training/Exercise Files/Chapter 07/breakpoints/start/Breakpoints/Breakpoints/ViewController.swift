//
//  ViewController.swift
//  Breakpoints
//
//  Created by LDC on 9/25/15.
//  Copyright © 2015 LDC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var sum = 0
        sum = example(3,n2:2)
        print("sum is \(sum)")
    }
    
    func example(n1:Int,n2:Int) -> Int {
        let total = n1 + n2
        return total
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

