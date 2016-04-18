//
//  HCChatViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/18/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

class HCChatViewController: UIViewController {

    /// The other user the current user is interacting with.
    var user = HCUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        title = user.name
    }

}
